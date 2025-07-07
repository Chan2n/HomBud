import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

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
                // Logo at the top
                Image.asset(
                  'lib/assets/img.png',
                  width: 200.0,
                ),
                const SizedBox(height: 20.0),
                // "Maayong adlaw" text below the logo
                const Text(
                  'Ma\'ayong adlaw!',
                  style: TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 10.0),
                // "Let's get started!" text
                const Text(
                  "Let's get started!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                // "Fullname" text aligned to the left
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full Name',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 5.0),
                // Fullname input field
                const SizedBox(
                  width: double.infinity, // Make input field wider
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'How do you want our HB experts to call you?',
                      hintStyle:
                          TextStyle(fontSize: 14.0), // Make hint text smaller
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // "Email" text aligned to the left
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 5.0),
                // Email input field
                const SizedBox(
                  width: double.infinity, // Make input field wider
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "What's your email?",
                      hintStyle:
                          TextStyle(fontSize: 14.0), // Make hint text smaller
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 110.0),
                // "By continuing, you agree to our Terms of Service and Privacy Policy" text
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text:
                            'By continuing, you confirm you have read and agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Add logic to navigate to Terms of Service screen
                          },
                      ),
                      const TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Add logic to navigate to Privacy Policy screen
                          },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10.0),
                // "Continue" button at the bottom
                SizedBox(
                  width: double.infinity, // Make button wider
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logic for "Continue" button
                    },
                    child: const Text('Apply as an HB Expert'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: NewScreen(),
    );
  }
}
