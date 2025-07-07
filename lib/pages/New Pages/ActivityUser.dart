import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Image.asset(
            'lib/assets/img.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle history button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'History',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Text(
                  'Ongoing',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ), // Ongoing text
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ac Filtering/Cleaning Replacement',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 60),
                          Text('Php 350'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'July 23, 2024',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 60),
                          Text('1:00 PM'),
                          SizedBox(width: 90),
                          Text(
                            'View More',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Recent',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ), // Ongoing text
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ac Filtering/Cleaning Replacement',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 60),
                          Text('Php 350'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'July 17, 2024',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 60),
                          Text('1:00 PM'),
                          SizedBox(width: 90),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Rate Your Expert',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, size: 20),
                          SizedBox(width: 10),
                          Text(
                            'Rebook',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 103),
                          Text(
                            'View More',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom navigation bar
          const SizedBox(height: 310),
          SizedBox(
            height: 70, // Adjust the height as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      5, // Adjust according to the number of items
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
                  width: MediaQuery.of(context).size.width /
                      5, // Adjust according to the number of items
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
                  width: MediaQuery.of(context).size.width /
                      5, // Adjust according to the number of items
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
                  width: MediaQuery.of(context).size.width /
                      5, // Adjust according to the number of items
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
                  width: MediaQuery.of(context).size.width /
                      5, // Adjust according to the number of items
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
        ],
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
      home: HistoryScreen(),
    );
  }
}
