import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertHomePageNew.dart';

class ExpertLoginFlow2 extends StatefulWidget {
  final String email;
  final String pin;
  final List<TextEditingController> pinControllers;

  const ExpertLoginFlow2({
    super.key,
    required this.email,
    required this.pin,
    required this.pinControllers,
  });

  @override
  _ExpertLoginFlow2State createState() => _ExpertLoginFlow2State();
}

class _ExpertLoginFlow2State extends State<ExpertLoginFlow2> {
  String enteredPin = '';
  final pinFocusNode = FocusNode();
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pinFocusNode.requestFocus();
    });
    pinController.addListener(() {
      if (pinController.text.length <= 6) {
        setState(() {
          enteredPin = pinController.text;
        });
      } else {
        pinController.text = enteredPin;
      }
    });
  }

  @override
  void dispose() {
    pinFocusNode.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    'Enter Pin',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Input your Registered Pin',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(pinFocusNode);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          6,
                          (index) =>
                              PinCircle(filled: index < enteredPin.length)),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Offstage(
                    offstage: true, // Keep it hidden
                    child: TextField(
                      focusNode: pinFocusNode,
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, letterSpacing: 24),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Check if enteredPin matches the stored pin
                      if (enteredPin == widget.pin) {
                        // Navigate to the ExpertHomePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpertHomePage(
                              email: widget.email,
                            ),
                          ),
                        );
                      } else {
                        // Display error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Incorrect pin. Please try again.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: const Color(0xFF003B5F), // Button color
                    ),
                    child: const Text('Continue'),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        enteredPin = '';
                        pinController.clear();
                      });
                      FocusScope.of(context).unfocus();
                      pinFocusNode.requestFocus();
                    },
                    child: const Text(
                      'Clear Pin',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
