import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repair & Maintenance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RepairMaintenanceScreen(),
    );
  }
}


class RepairMaintenanceScreen extends StatefulWidget {
  const RepairMaintenanceScreen({super.key});

  @override
  _RepairMaintenanceScreenState createState() => _RepairMaintenanceScreenState();
}

class _RepairMaintenanceScreenState extends State<RepairMaintenanceScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Repair & Maintenance'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 400,
              height: 265,
              padding: const EdgeInsets.only(), // Adjust the left padding as needed
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20,left: 20), // Adjust vertical padding as needed
                    child: Text(
                      'Water Heater Services',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Increase font size
                    ),
                  ),


            const SizedBox(height: 1),
                  const Padding(
                    padding: EdgeInsets.only(left: 20), // Adjust vertical padding as needed
                    child: Text(
                      'Filter Cleaning',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Increase font size
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10,left: 50), // Adjust vertical padding as needed
                    child: Text(
                      '4.80 (2.5K bookings)',
                      style: TextStyle( fontSize: 12), // Increase font size
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20,left: 60), // Adjust vertical padding as needed
                    child: Text(
                      'Check for available offers',
                      style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold), // Increase font size
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25,left: 25), // Add left margin as needed
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4), // Adjust the horizontal padding as needed
                      child: Divider(
                        thickness: 2, // Adjust the thickness of the divider as needed
                        color: Colors.grey, // Adjust the color of the divider as needed
                      ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(left:40), // Adjust the padding as needed
                    child: Row(
                      children: [
                        const Text(
                          'PHP 660', // First text widget
                          style: TextStyle(fontSize: 12), // Adjust the font size as needed
                        ),
                        const SizedBox(width: 50), // Adjust the spacing between widgets as needed
                        const Icon(
                          Icons.access_time, // Clock icon
                          size: 20, // Adjust the icon size as needed
                        ),
                        const SizedBox(width: 10), // Adjust the spacing between widgets as needed
                        const Text(
                          '1 hr', // Second text widget
                          style: TextStyle(fontSize: 12), // Adjust the font size as needed
                        ),
                        const SizedBox(width: 50), // Adjust the spacing between widgets as needed
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple, // Button background color
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5), // Adjust padding as needed
                          ),
                          child: const Text(
                            'Add', // Button text
                            style: TextStyle(color: Colors.white), // Button text color
                          ),
                        ),
                      ],
                    ),
                  ),const Padding(
                    padding: EdgeInsets.only(left: 40, top: 10), // Adjust the left padding as needed
                    child: Text(
                      'Fun fact! A typical water heater can hold up to\n40 to 60 gallons of hot water at any given\ntime!',
                      style: TextStyle(fontSize: 11), // Increase font size
                    ),
                  )


                ],
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10), // Circular border radius
                ),
                height: 150,
                width: 300,
                padding: const EdgeInsets.all(10), // Padding for the content inside the container
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.notes, color: Colors.blue), // Notes icon
                          SizedBox(width: 10), // Spacer
                          Text(
                            'Service Details', // Text beside the icon
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5), // Spacer
                    Padding(
                      padding: EdgeInsets.only(left: 20), // Add left padding
                      child: Row(
                        children: [
                           // Notes icon
                          SizedBox(width: 10), // Spacer
                          Text(
                            'Thorough cleaning of the water heater filter\nto remove debris and sediment, ensuring\nefficient water heating. Ensure safe and clean\nwater with our water heater filter cleaning.', // Text beside the icon
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5), // Spacer
                    Padding(
                      padding: EdgeInsets.only(left: 60,top: 10), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8), // Dot icon
                          SizedBox(width: 5), // Spacer
                          Text(
                            'Materials will be provided by requester', style: TextStyle(fontSize: 10), // Additional information text
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10), // Circular border radius
                ),
                height: 120,
                width: 300,
                padding: const EdgeInsets.all(10), // Padding for the content inside the container
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, size: 20, color: Colors.blue), // Notes icon
                          SizedBox(width: 10), // Spacer
                          Text(
                            'Inclusions', // Text beside the icon
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5), // Spacer
                    // Spacer
                    Padding(
                      padding: EdgeInsets.only(left: 15,top: 5), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8), // Dot icon
                          SizedBox(width: 5), // Spacer
                          Text(
                            'Thorough cleaning of water heater filter', style: TextStyle(fontSize: 10), // Additional information text
                          ),
                        ],
                      ),
                    ), // Spacer
                    // Spacer
                    Padding(
                      padding: EdgeInsets.only(left: 15,top: 5), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8), // Dot icon
                          SizedBox(width: 5), // Spacer
                          Text(
                            'Removes sediment and debris', style: TextStyle(fontSize: 10), // Additional information text
                          ),
                        ],
                      ),
                    ), // Spacer
                    // Spacer
                    Padding(
                      padding: EdgeInsets.only(left: 15,top: 5), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8), // Dot icon
                          SizedBox(width: 5), // Spacer
                          Text(
                            'Ensures efficient water heating', style: TextStyle(fontSize: 10), // Additional information text
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10), // Circular border radius
                ),
                height: 120,
                width: 300,
                padding: const EdgeInsets.all(10), // Padding for the content inside the container
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10), // Add left padding
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, size: 20, color: Colors.blue), // Notes icon
                          SizedBox(width: 10), // Spacer
                          Text(
                            'Note', // Text beside the icon
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5), // Spacer
                    // Spacer
                    Padding(
                      padding: EdgeInsets.only(left: 15,top: 5), // Add left padding
                      child: Row(
                        children: [ // Spacer
                          Text(
                            'HB Experts will arrive with the necessary\ninstruments to conduct the requested service.\nOur HB Experts will not carry a ladder, so please\nlet them know if you require one to access the\nunit.', style: TextStyle(fontSize: 10), // Additional information text
                          ),
                        ],
                      ),
                    ), // Spacer


                  ],
                ),
              ),

            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20), // Add left padding
              child: Row(
                children: [
                  Icon(Icons.help_outline, color: Colors.blue),
                  SizedBox(width: 5),
                  Text('Frequently Asked Questions'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 20), // Add left and top padding
              child: Row(
                children: [
                  Text('1. What does water heater filter cleaning involve?'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15), // Add left and top padding
              child: Row(
                children: [
                  Text('2. Why is filter cleaning important?'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15), // Add left and top padding
              child: Row(
                children: [
                  Text('3. Can I clean the filters myself?'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15), // Add left and top padding
              child: Row(
                children: [
                  Text('4. How often should I clean the filters?'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15), // Add left and top padding
              child: Row(
                children: [
                  Text('5. Is professional cleaning necessary?'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30), // Add left padding
              child: Text(
                'Customer Reviews',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30), // Add left padding
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.grey),
                  SizedBox(width: 10),
                  Text('4.80', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Text('(2.5k bookings)', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[200],
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
