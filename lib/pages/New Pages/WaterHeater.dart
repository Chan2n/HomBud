import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repair & Maintenance Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RepairMaintenanceScreen(),
    );
  }
}

class RepairMaintenanceScreen extends StatelessWidget {
  const RepairMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Repair & Maintenance')), // App bar title centered
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20), // Add padding to the left
              child: Text(
                'Water Heater Services', // Bold text
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 60), // Padding for normal text
              child: Text(
                '5.0 (1,480 Bookings)', // Normal text
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 70), // Padding for normal text
              child: Text(
                'Check for available offers', // Normal text
              ),
            ),
            const SizedBox(height: 2), // Spacer
            const Divider(thickness: 2), // Thickened divider
            const SizedBox(height: 10), // Spacer
            const Text(
              'Filter Cleaning',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple, // Bold text color purple
              ),
            ),
            const Row(
              children: [
                Icon(
                  Icons.star, // Star icon
                  color: Colors.orange, // Star icon color
                ),
                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(left: 10), // Padding for normal text
                  child: Text(
                    '4.80 (2.5K bookings)', // Normal text after star icon
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5), // Padding for normal text
                  child: Text(
                    'PHP 660', style:TextStyle(color: Colors.blue)// Normal text after star icon
                  ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.black, // Color of the dot
                  radius: 4, // Adjust the size of the dot as needed
                ),

                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(left: 10), // Padding for normal text
                  child: Text(
                    '1 hr - 2 hr', style:TextStyle(color: Colors.purple)// Normal text after star icon
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2), // Spacer
            Container(
              margin: const EdgeInsets.only(right: 200), // Add left margin as needed
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4), // Adjust the horizontal padding as needed
                child: Divider(
                  thickness: 2, // Adjust the thickness of the divider as needed
                  color: Colors.grey, // Adjust the color of the divider as needed
                ),
              ),
            ),
 // Thickened divider
            const SizedBox(height: 2), // Spacer
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30), // Padding for normal text
                        child: Text(
                          'Professional Installation',style: TextStyle(color: Colors.grey), // Normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.only(left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',style: TextStyle(color: Colors.grey), // Another normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10), // Padding for normal text
                        child: Text(
                          'View Details',
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold), // Normal text color blue
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30), // Margin from the top of the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Add button color dark blue
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5), // Button padding
                    ),
                    child: const Text('Add', style: TextStyle(fontSize: 18, color: Colors.white)), // Increased button size
                  ),
                ),
                const SizedBox(width: 30), // Spacer between texts and button
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Pullout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple, // Bold text color purple
              ),
            ),
            const Row(
              children: [
                Icon(
                  Icons.star, // Star icon
                  color: Colors.orange, // Star icon color
                ),
                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(left: 10), // Padding for normal text
                  child: Text(
                    '4.80 (2.5K bookings)', // Normal text after star icon
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5), // Padding for normal text
                  child: Text(
                      'PHP 2220', style:TextStyle(color: Colors.blue)// Normal text after star icon
                  ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.black, // Color of the dot
                  radius: 4, // Adjust the size of the dot as needed
                ),

                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(left: 10), // Padding for normal text
                  child: Text(
                      '1 hr - 2 hr', style:TextStyle(color: Colors.purple)// Normal text after star icon
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2), // Spacer
            Container(
              margin: const EdgeInsets.only(right: 200), // Add left margin as needed
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4), // Adjust the horizontal padding as needed
                child: Divider(
                  thickness: 2, // Adjust the thickness of the divider as needed
                  color: Colors.grey, // Adjust the color of the divider as needed
                ),
              ),
            ),
            // Thickened divider
            const SizedBox(height: 2), // Spacer
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30), // Padding for normal text
                        child: Text(
                          'Professional Installation',style: TextStyle(color: Colors.grey), // Normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.only(left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',style: TextStyle(color: Colors.grey), // Another normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10), // Padding for normal text
                        child: Text(
                          'View Details',
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold), // Normal text color blue
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30), // Margin from the top of the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Add button color dark blue
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5), // Button padding
                    ),
                    child: const Text('Add', style: TextStyle(fontSize: 18, color: Colors.white)), // Increased button size
                  ),
                ),
                const SizedBox(width: 30),
                // Spacer between texts and button
              ],
            ), const SizedBox(height: 50),
            const Divider(thickness: 2), // Divider at the bottom
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(right: 100,left: 40), // Add padding to the right
              child: Row(
                children: [
                  Text(
                    'Item(s)',style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '0',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            const Padding(
              padding: EdgeInsets.only(right: 100,left: 40), // Add padding to the right
              child: Row(
                children: [
                  Text(
                    'TOTAL',style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    'PHP 0',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.blue),
                  ),
                ],
              ),
            ),const SizedBox(height: 30),
            Center( // Center the button horizontally
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5), // Button padding
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),


          ],

        ),
      ),
    );
  }
}
