import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow7.dart';

class PinScreen extends StatefulWidget {
  final String userID;

  const PinScreen({super.key, required this.userID});

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
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
                  'Finally your final step',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Enter 6 numbers to keep your account safe',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      6, (index) => PinCircle(filled: index < pin.length)),
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
                ElevatedButton(
                  onPressed: () => _showConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor: const Color(0xFF003B5F), // Button color
                  ),
                  child: const Text('Continue'),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: const Text("Cancel"),
                onPressed: () =>
                    Navigator.of(context).pop(), // Dismiss the dialog
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF003B5F), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: const Text("Yes"),
                onPressed: () async {
                  // Dismiss the dialog
                  Navigator.of(context).pop();
                  // Save the PIN to Firestore under the user's document
                  FirebaseFirestore.instance
                      .collection('User')
                      .doc(widget.userID)
                      .update({
                    'pin': pin,
                  }).then((_) {
                    print('PIN saved successfully.');
                    // Navigate to the next screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TermsAndConditionScreen()),
                    );
                  }).catchError((error) {
                    print('Failed to save PIN: $error');
                    // Optionally, handle any errors, perhaps by showing an error dialog
                  });
                },
              ),
            ],
          );
        },
      );
    } else {
      // Optionally handle the case where the PIN is not 6 digits
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a 6-digit PIN.")),
      );
    }
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
