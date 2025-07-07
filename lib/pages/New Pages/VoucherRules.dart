import 'package:flutter/material.dart';

class VoucherDealsScreen extends StatelessWidget {
  const VoucherDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.lightBlue[200], // Set background color
          title: Column(
            children: [
              Image.asset('lib/assets/img.png', width: 50, height: 30), // Logo
              const Text(
                'VOUCHER DEALS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('lib/assets/img_24.png', width: 50, height: 50), // Adjust image path and size
                const SizedBox(width: 15), // Add some spacing between the image and text
                const Text(
                  '[LIMITED TIME] P100 OFF',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 116), // Adjust the right padding as needed
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                ),
                child: const Text(
                  'Expiring in 2 days',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),
            const Text(
              'Event Rewards:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Use this Limited Time voucher and get to enjoy P100 OFF with a minimum spending of P660 in any of the services available.\n\nPromo is valid from May 1-30, 2024 from 8am to 5pm',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 320),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add onPressed functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  'Use Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: VoucherDealsScreen(),
//     );
//   }
// }
