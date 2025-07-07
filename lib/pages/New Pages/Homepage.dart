
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0067A5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/img.png', // Adjust image path
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 1), // Add some space between the texts
            Padding(
              padding: const EdgeInsets.only(left: 90), // Adjust the left padding as needed
              child: Row(
                children: [
                  Image.asset(
                    'lib/assets/img_35.png', // Adjust image path
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(width: 20), // Add spacing between images
                  Image.asset(
                    'lib/assets/img_36.png', // Adjust image path
                    width: 90,
                    height: 90,
                  ),
                ],
              ),
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
      title: 'My App',
      home: SplashScreen(), // Set SplashScreen as the initial route
    );
  }
}
