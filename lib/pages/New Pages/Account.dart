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
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, left: 70), // Add top margin
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25, // Adjust the radius as needed
                    backgroundColor: Colors.blue, // Border color
                    child: CircleAvatar(
                      radius:
                          24, // Adjust the inner circle radius to accommodate the border
                      backgroundImage: AssetImage('lib/assets/img_32.png'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Anthony Dela Cruz',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text("09173454724", style: TextStyle(fontSize: 14)),
                        Text("Update Profile",
                            style: TextStyle(fontSize: 14, color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Manage Linked Bank Accounts ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'My Rewards ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Saved Locations ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Settings ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Chat with HomBuddy ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Help Center ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Terms and Conditions ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Privacy Policy ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Become an Expert ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 360,
              height: 40,
              // Align the container's content to the center
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              padding: const EdgeInsets.only(left: 30, top: 10), // Add padding
              child: const Text(
                textAlign: TextAlign.start,
                'Logout ', // Text inside the container
                style: TextStyle(
                  color: Colors.blue, // Set text color to blue
                ),
                // Align text to the left
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
              color: _selectedIndex == index
                  ? Colors.blue
                  : null, // Change color when selected
            ),
            Text(
              title,
              style: TextStyle(
                  color: _selectedIndex == index
                      ? Colors.blue
                      : null), // Change text color when selected
            ),
          ],
        ),
      ),
    );
  }
}
