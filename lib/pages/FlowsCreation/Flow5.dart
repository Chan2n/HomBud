import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow5.1.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow6.dart';

class NameSection extends StatelessWidget {
  final String userID;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  NameSection({super.key, required this.userID});

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
                    'lib/assets/images/MaayongAdlawHom.png',
                    width: 200.0,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Let's get started!",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Full Name',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      hintText: 'How do you want our HB experts to call you?',
                      hintStyle: TextStyle(
                          fontSize: 12.0), // Smaller font size for hint text
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "What's your email?",
                      hintStyle: TextStyle(
                          fontSize: 12.0), // Smaller font size for hint text
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.black),
                      children: [
                        const TextSpan(
                            text:
                                'By continuing, you confirm you have read and agree to our '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Terms of Service
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditionLog(),
                                ),
                              );
                            },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditionLog(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity, // Adjust width as needed
                    child: ElevatedButton(
                      onPressed: () => _saveNameAndEmail(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                        backgroundColor:
                            const Color(0xFF003B5F), // Button color
                      ),
                      child: const Text('Continue'),
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

  void _saveNameAndEmail(BuildContext context) async {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();

    if (fullName.isNotEmpty && email.isNotEmpty) {
      // Check if the email ends with either "@gmail.com" or "@yahoo.com"
      if (email.endsWith('@gmail.com') || email.endsWith('@yahoo.com')) {
        await FirebaseFirestore.instance.collection('User').doc(userID).update({
          'fullName': fullName,
          'email': email,
        }).then((_) {
          print("User info updated successfully.");
          // Optionally, navigate to the next page or show a success dialog/message
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              // Replace with your actual next flow/widget
              builder: (context) => PinScreen(userID: userID),
            ),
          );
        }).catchError((error) {
          print("Failed to update user info: $error");
          // Optionally, show an error dialog/message
        });
      } else {
        // Display an error message if the email doesn't end with "@gmail.com" or "@yahoo.com"
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Invalid Email"),
              content: const Text(
                  "Please enter a valid email ending with '@gmail.com' or '@yahoo.com'."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } else {
      print("Full name and email cannot be empty.");
      // Show an error message to the user
    }
  }
}
