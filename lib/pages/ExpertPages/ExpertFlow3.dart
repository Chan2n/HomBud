import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow4.dart';

class ExpertFlow3 extends StatefulWidget {
  final String expertId;
  final String fullName; // Add fullName parameter

  const ExpertFlow3(
      {super.key, required this.expertId, required this.fullName});

  @override
  _ExpertFlow3State createState() => _ExpertFlow3State();
}

class _ExpertFlow3State extends State<ExpertFlow3> {
  String pin = '';
  final pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => focusNode.requestFocus());
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/Pinn.png',
                  width: 200.0,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Put a pin on your account',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Enter 6 numbers to keep your account safe',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        6, (index) => PinCircle(filled: index < pin.length)),
                  ),
                ),
                const SizedBox(height: 20.0),
                Offstage(
                  offstage: true,
                  child: TextField(
                    focusNode: focusNode,
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onChanged: (value) {
                      setState(() {
                        pin = value;
                      });
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 24),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003B5F),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    if (pin.length == 6) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm PIN"),
            content: const Text("Are you sure with your PIN?"),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(), // Dismiss the dialog
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                ),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  _showLoadingDialog(context); // Show loading dialog
                  try {
                    await FirebaseFirestore.instance
                        .collection('Expert')
                        .doc(widget.expertId)
                        .update({
                      'pin': pin,
                      'totalRatings': 0,
                      'aveRatings': 0.0,
                    });
                    print('PIN and ratings saved successfully.');

                    if (mounted) {
                      Navigator.of(context).pop(); // Dismiss the loading dialog
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExpertFlow4(
                            expertId: widget.expertId,
                            fullName: widget.fullName,
                          ),
                        ),
                      );
                    }
                  } catch (error) {
                    print('Failed to save PIN and ratings: $error');
                    if (mounted) {
                      Navigator.of(context).pop(); // Dismiss the loading dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Failed to save PIN and ratings.")),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF003B5F),
                ),
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a 6-digit PIN.")),
      );
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Saving PIN...'),
            ],
          ),
        );
      },
    );
  }
}

class PinCircle extends StatelessWidget {
  final bool filled;

  const PinCircle({super.key, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? Colors.black : Colors.transparent,
          border: Border.all(color: filled ? Colors.transparent : Colors.black),
        ),
      ),
    );
  }
}
