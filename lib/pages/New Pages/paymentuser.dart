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
class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  _NewScreenState createState() => _NewScreenState();
}


class _NewScreenState extends State<NewScreen> {
  int _selectedIndex = 0;
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Currently Linked',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: const Padding(
                padding: EdgeInsets.only(left: 110), // Adjust the left padding as needed
                child: Row(
                  children: [
                    Text('PNB',style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Icon(Icons.more_horiz),
                    Icon(Icons.more_horiz), // Multiple dots icon
                    SizedBox(width: 10),
                    Text('211',style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

            ),
            const SizedBox(height: 20),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: const Padding(
                padding: EdgeInsets.only(left: 110), // Adjust the left padding as needed
                child: Row(
                  children: [
                    Text('Gcash',style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Icon(Icons.more_horiz),
                    Icon(Icons.more_horiz), // Multiple dots icon
                    SizedBox(width: 10),
                    Text('724',style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

            ),
            const SizedBox(height: 20),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
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
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavItem(0, 'Activity', 'lib/assets/img_3.png'),
            buildNavItem(1, 'Payment', 'lib/assets/img_4.png'),
            buildNavItem(2, 'Home', 'lib/assets/img_10.JPG'),
            buildNavItem(3, 'Messages', 'lib/assets/img_6.png'),
            buildNavItem(4, 'Account', 'lib/assets/img_7.png'),
          ],
        ),
      ),
    );
  }
  Widget buildNavItem(int index, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
              color: _selectedIndex == index ? Colors.blue : null, // Change color when selected
            ),
            Text(
              title,
              style: TextStyle(color: _selectedIndex == index ? Colors.blue : null), // Change text color when selected
            ),
          ],
        ),
      ),
    );
  }
}
