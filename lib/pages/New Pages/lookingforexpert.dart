import 'package:flutter/material.dart';

class PurpleScreen extends StatelessWidget {
  const PurpleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003B5F), // Set background color to #003B5F
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150), // Adjust spacing as needed
            const Text(
              "Hold On Tight",
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontSize: 36.0,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "We are Looking for the\n   right Expert for you!",
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 20), // Adjust spacing as needed
            Image.asset(
              'lib/assets/img_38.png', // Adjust the image path
              width: MediaQuery.of(context).size.width * 0.8, // Set image width to 80% of screen width
              // Set image height aspect ratio based on image dimensions
              // height: MediaQuery.of(context).size.width * 0.8 / aspectRatio,
            ),
          ],
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
      title: 'Purple Screen',
      home: PurpleScreen(),
    );
  }
}
