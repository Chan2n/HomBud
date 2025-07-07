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
        title: const Center(
            child: Text('Repair & Maintenance')), // App bar title centered
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 500,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add border
                borderRadius: BorderRadius.circular(
                    10), // Optional: Add border radius for rounded corners
              ),
              padding: const EdgeInsets.all(20), // Adjust padding as needed
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20), // Add padding to the left
                    child: Text(
                      'Home Cleaning Services', // Bold text
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 60), // Padding for normal text
                    child: Text('5.0 (1,480 Bookings)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold) // Normal text
                        ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 70), // Padding for normal text
                    child: Text('Check for available offers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold) // Normal text
                        ),
                  ),
                  Divider(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.purple, // Change container color to purple
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Basic Services',
                            style: TextStyle(
                                color: Colors.white), // Adjust text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.purple, // Change container color to purple
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cleaning Services',
                            style: TextStyle(
                                color: Colors.white), // Adjust text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.purple, // Change container color to purple
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'AC Freon Charging',
                            style: TextStyle(
                                color: Colors.white), // Adjust text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.purple, // Change container color to purple
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Basic Services',
                            style: TextStyle(
                                color: Colors.white), // Adjust text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.purple, // Change container color to purple
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cleaning Services',
                            style: TextStyle(
                                color: Colors.white), // Adjust text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Colors.purple, // Change container color to purple
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'AC Freon Charging',
                            style: TextStyle(
                                color: Colors.white), // Adjust text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10), // Spacer
            const Text(
              'ACU Cleaning Services',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue, // Bold text color purple
              ),
            ),
            const SizedBox(height: 20), // Spacer
            const Text(
              'Window Type',
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
                  padding: EdgeInsets.only(
                      left: 10), // Padding for normal text
                  child: Text(
                    '4.80 (2.5K bookings)', // Normal text after star icon
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5), // Padding for normal text
                  child: Text('PHP 660',
                      style: TextStyle(
                          color: Colors.blue) // Normal text after star icon
                      ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.black, // Color of the dot
                  radius: 4, // Adjust the size of the dot as needed
                ),

                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(
                      left: 10), // Padding for normal text
                  child: Text('1 hr - 2 hr',
                      style: TextStyle(
                          color: Colors.purple) // Normal text after star icon
                      ),
                ),
              ],
            ),
            const SizedBox(height: 2), // Spacer
            Container(
              margin: const EdgeInsets.only(right: 180), // Adjust margin as needed
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 4), // Adjust padding as needed
                child: DottedDivider(
                  thickness: 2, // Adjust thickness as needed
                  height: 2, // Adjust height as needed
                  color: Colors.grey, // Adjust color as needed
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
                        padding: EdgeInsets.only(
                            left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',
                          style: TextStyle(color: Colors.grey), // Normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',
                          style: TextStyle(
                              color: Colors.grey), // Another normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10), // Padding for normal text
                        child: Text(
                          'View Details',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight:
                                  FontWeight.bold), // Normal text color blue
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 30), // Margin from the top of the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // Add button color dark blue
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 5), // Button padding
                    ),
                    child: const Text('0',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black)), // Increased button size
                  ),
                ),
                const SizedBox(width: 30), // Spacer between texts and button
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Split Type',
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
                  padding: EdgeInsets.only(
                      left: 10), // Padding for normal text
                  child: Text(
                    '4.80 (2.5K bookings)', // Normal text after star icon
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5), // Padding for normal text
                  child: Text('PHP 1140',
                      style: TextStyle(
                          color: Colors.blue) // Normal text after star icon
                      ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.black, // Color of the dot
                  radius: 4, // Adjust the size of the dot as needed
                ),

                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(
                      left: 10), // Padding for normal text
                  child: Text('1 hr - 2 hr',
                      style: TextStyle(
                          color: Colors.purple) // Normal text after star icon
                      ),
                ),
              ],
            ),
            const SizedBox(height: 2), // Spacer
            Container(
              margin: const EdgeInsets.only(right: 180), // Adjust margin as needed
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 4), // Adjust padding as needed
                child: DottedDivider(
                  thickness: 2, // Adjust thickness as needed
                  height: 2, // Adjust height as needed
                  color: Colors.grey, // Adjust color as needed
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
                        padding: EdgeInsets.only(
                            left: 30), // Padding for normal text
                        child: Text(
                          'Professional Installation',
                          style: TextStyle(color: Colors.grey), // Normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',
                          style: TextStyle(
                              color: Colors.grey), // Another normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10), // Padding for normal text
                        child: Text(
                          'View Details',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight:
                                  FontWeight.bold), // Normal text color blue
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 30), // Margin from the top of the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.purple, // Add button color dark blue
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 5), // Button padding
                    ),
                    child: const Text('Add',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white)), // Increased button size
                  ),
                ),
                const SizedBox(width: 30),
                // Spacer between texts and button
              ],
            ),
            const Text(
              'Window Type',
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
                  padding: EdgeInsets.only(
                      left: 10), // Padding for normal text
                  child: Text(
                    '4.80 (2.5K bookings)', // Normal text after star icon
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5), // Padding for normal text
                  child: Text('PHP 660',
                      style: TextStyle(
                          color: Colors.blue) // Normal text after star icon
                      ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.black, // Color of the dot
                  radius: 4, // Adjust the size of the dot as needed
                ),

                SizedBox(width: 5), // Spacer
                Padding(
                  padding: EdgeInsets.only(
                      left: 10), // Padding for normal text
                  child: Text('1 hr - 2 hr',
                      style: TextStyle(
                          color: Colors.purple) // Normal text after star icon
                      ),
                ),
              ],
            ),
            const SizedBox(height: 2), // Spacer
            Container(
              margin: const EdgeInsets.only(right: 180), // Adjust margin as needed
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 4), // Adjust padding as needed
                child: DottedDivider(
                  thickness: 2, // Adjust thickness as needed
                  height: 2, // Adjust height as needed
                  color: Colors.grey, // Adjust color as needed
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
                        padding: EdgeInsets.only(
                            left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',
                          style: TextStyle(color: Colors.grey), // Normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30), // Padding for normal text
                        child: Text(
                          'Experienced Experts',
                          style: TextStyle(
                              color: Colors.grey), // Another normal text
                        ),
                      ),
                      SizedBox(height: 3),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10), // Padding for normal text
                        child: Text(
                          'View Details',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight:
                                  FontWeight.bold), // Normal text color blue
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 30), // Margin from the top of the screen
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // Add button color dark blue
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 5), // Button padding
                    ),
                    child: const Text('0',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black)), // Increased button size
                  ),
                ),
                const SizedBox(width: 30), // Spacer between texts and button
              ],
            ),
            const SizedBox(height: 50),
            const Divider(thickness: 2), // Divider at the bottom
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(
                  right: 100, left: 40), // Add padding to the right
              child: Row(
                children: [
                  Text(
                    'Item(s)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    '0',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            const Padding(
              padding: EdgeInsets.only(
                  right: 100, left: 40), // Add padding to the right
              child: Row(
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    'PHP 0',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              // Center the button horizontally
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Button color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 5), // Button padding
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

class DottedDivider extends StatelessWidget {
  final double thickness;
  final double height;
  final Color color;

  const DottedDivider({
    super.key,
    this.thickness = 1.0,
    this.height = 1.0,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromHeight(height),
      painter: DottedPainter(color: color, thickness: thickness),
    );
  }
}

class DottedPainter extends CustomPainter {
  final Color color;
  final double thickness;

  DottedPainter({required this.color, this.thickness = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;

    const double dashWidth = 5.0;
    const double dashSpace = 5.0;
    double currentX = 0.0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0),
        Offset(currentX + dashWidth, 0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
