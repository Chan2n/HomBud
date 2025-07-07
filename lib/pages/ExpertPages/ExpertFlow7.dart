import 'package:flutter/material.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertLoginFlow1.dart';

class ExpertFlow7 extends StatelessWidget {
  final String expertId;
  final String fullName;

  const ExpertFlow7({
    super.key,
    required this.expertId,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'lib/assets/images/OneStep.png', // Adjustable asset image
                    height: 200, // Adjust the height as needed
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "You Are a Step Closer",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "We have received your initial requirements. Please wait for our team to contact you on the contact details you inputted.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "While waiting, you may prepare ahead the following requirements:\n"
                    "     a. NBI Clearance\n"
                    "     b. Two (2) Valid Government IDs\n"
                    "     c. Resume\n"
                    "     d. Certificates",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExpertLoginFlow1(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003B5F),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 50.0),
                    ),
                    child: const Text(
                      'I Understand',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Image.asset(
              'lib/assets/images/homblue.png',
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }
}
