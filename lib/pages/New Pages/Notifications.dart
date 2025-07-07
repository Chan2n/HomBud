import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewScreen(),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'lib/assets/img.png', // Replace 'assets/logo.png' with your logo image path
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                'Updates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Be the first to know our latest updates',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('Push Notifications'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('Email'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('SMS'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Deals & Offers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Based on your profile and marketing communications',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('Push Notifications'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('Email'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('SMS'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Feedback',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Provide feedback to help make HomBuddy better',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('Push Notifications'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('Email'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    const Text('SMS'),
                    const Spacer(),
                    Switch(
                      value: false, // Switch is initially turned off
                      onChanged: (bool newValue) {
                        // Handle switch state change
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
