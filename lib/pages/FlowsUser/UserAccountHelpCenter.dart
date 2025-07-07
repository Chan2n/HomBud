import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HelpCenter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 cards per row
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: List.generate(6, (index) {
            return _buildHelpCard(index, context);
          }),
        ),
      ),
    );
  }

  Widget _buildHelpCard(int index, BuildContext context) {
    List<String> titles = [
      'App Issues & Feedback',
      'Security & Privacy Issues',
      'Voucher/Reward Issues',
      'Payment & Wallet Issues',
      'Booking/Availability Issue',
      'Challenges Issues'
    ];

    List<String> images = [
      'lib/assets/images/App.png',
      'lib/assets/images/Security.png',
      'lib/assets/images/Voucher.png',
      'lib/assets/images/Payment1.png',
      'lib/assets/images/Booking.png',
      'lib/assets/images/Challenges.png'
    ];

    return Card(
      color: const Color(0xFFEFEDED), // Grey color for the card
      elevation: 4.0, // Add shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // More rounded corners
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0), // Match card's shape
        onTap: () {
          // Handle card tap here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${titles[index]} tapped')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              images[index],
              width: 250,
              height: 100,
            ),
            Text(
              titles[index],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
