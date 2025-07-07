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
  bool isRecentSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text('Home'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20), // Adjust the left padding as needed
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isRecentSelected = true;
                      });
                    },
                    child: Text(
                      'Recent',
                      style: TextStyle(
                        color: isRecentSelected ? Colors.purple : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isRecentSelected = false;
                      });
                    },
                    child: Text(
                      'Saved',
                      style: TextStyle(
                        color: isRecentSelected ? Colors.black : Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 15,
                ),
                SizedBox(width: 10),
                Text(
                  'Add New',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding as needed
            child: const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 15,
                    ),
                    SizedBox(height: 10), // Adjust height as needed
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Valley View Village, Unnamed Road, Mohon',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Talisay City, Cebu, 6045, Central Visayas',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
           const SizedBox(height: 20),
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 15,
                ),
                SizedBox(width: 10),
                Text(
                  'Add New',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjust padding as needed
            child: const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 15,
                    ),
                    SizedBox(height: 5), // Adjust height as needed
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Condo Unit 1',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'One Oasis Cebu, Kasambagan, Cebu City',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Cebu, 6000, Central Visayas, (Region VII)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
