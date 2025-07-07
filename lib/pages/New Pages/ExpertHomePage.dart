import 'package:flutter/material.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today), // Calendar icon
               // Add spacing between icon and text
              Text(
                'July 23, 2024', // Date
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          Image.asset(
            'lib/assets/img_37.png', // Adjust logo path
            width: 50,
            height: 50,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Ma'ayong Adlaw,",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                'Giovanni Rey Joseph Canubida',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                'New Jobs',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
              ),
              const SizedBox(height: 1),
              Container(
                height: 230, // Adjust height as needed
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple, // Set purple color for the button
                                    ),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16), // Add spacing between buttons
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Decline'),
                                  ),
                                ),
                              ],
                            ),




                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple, // Set purple color for the button
                                    ),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16), // Add spacing between buttons
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Decline'),
                                  ),
                                ),
                              ],
                            ),




                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple, // Set purple color for the button
                                    ),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16), // Add spacing between buttons
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3, // Adjust the width as needed
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Decline'),
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
              ),
              const Text(
                'Jobs Today',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
              ),
              const SizedBox(height: 1),
              Container(
                height: 230, // Adjust height as needed
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),


                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),


                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),


                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ),
              const Text(
                'Upcoming jobs',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
              ),
              const SizedBox(height: 1),
              Container(
                height: 230, // Adjust height as needed
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),



                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),




                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Tuesday',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  'July 23, 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  '1:00 PM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25, // Adjust the radius as needed
                                  backgroundColor: Colors.blue, // Border color
                                  child: CircleAvatar(
                                    radius: 24, // Adjust the inner circle radius to accommodate the border
                                    backgroundImage: AssetImage('lib/assets/img_32.png'),
                                  ),
                                ),
                                SizedBox(width: 10), // Add spacing between avatar and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catriona Dianna G. Blu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Valley View Village, Brgy. Mohon, ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'City of Talisay ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add spacer to push the following widgets to the right
                              ],
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(left: 7), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  Text(
                                    'Repair and Maintenance Services',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios, // Choose the appropriate icon
                                    color: Colors.black, // Adjust the color as needed
                                  ),
                                ],
                              ),

                            ),




                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                      'lib/assets/img_38.JPG',
                      // Change 'lib/assets/img_3.png' to your image asset path
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                  ),
                  const Text('Profile'),
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
                  const Text('Wallet'),
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
                    'lib/assets/img_24.png',
                    // Change 'lib/assets/img_6.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Dashboard'),
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
                    // Change 'lib/assets/img_7.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Messages'),
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
      title: 'Custom Screen',
      home: CustomScreen(),
    );
  }
}
