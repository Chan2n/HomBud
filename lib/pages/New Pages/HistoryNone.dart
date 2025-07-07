import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'lib/assets/img.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/img_34.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    // Adjust the top padding as needed
                    child: Image.asset(
                      'lib/assets/img_3.png',
                      // Change 'lib/assets/img_3.png' to your image asset path
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                  ),
                  const Text('Activity'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/img_4.png',
                    // Change 'lib/assets/img_4.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Payment'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/img_10.JPG',
                    // Change 'lib/assets/img.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Home'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/img_6.png',
                    // Change 'lib/assets/img_6.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Messages'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/img_7.png',
                    // Change 'lib/assets/img_7.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Account'),
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
      title: 'Image Screen',
      home: ImageScreen(),
    );
  }
}
