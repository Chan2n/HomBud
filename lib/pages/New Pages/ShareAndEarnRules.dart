import 'package:flutter/material.dart';

class ShareAndEarnRulesScreen extends StatelessWidget {
  const ShareAndEarnRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share & Earn Rules'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Event Introduction:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Participants can share the Share & Earn event with their friends through various channels such as social media, email, or direct messaging. When a friend registers on HomBuddy via the shared link, both the participant and their friend will receive rewards based on the event terms.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Event Rewards:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildRewardItem(
              'Participant\'s Reward:',
              'Upon successful registration of a referred friend, the participant will receive a 15% discount coupon applicable on services priced over a certain amount valid for 3 months. These coupons cannot be combined with other coupons.',
            ),
            const SizedBox(height: 10),
            _buildRewardItem(
              'Referred Friend\'s Reward:',
              'After successfully registering on HomBuddy through the shared link, the referred friend will receive an additional 10% discount coupon applicable on services priced over a certain amount valid for 3 months.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Redeem Rewards:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Participants can redeem their discount coupons by applying them during the checkout process when booking HomBuddy services through the HomBuddy mobile app. Referred friends can redeem their discount coupons in the same manner when booking their first service on HomBuddy.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Event Completion Requirement:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Participants must ensure that the entire event sharing process is completed within the event period to qualify for the corresponding rewards.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
      ],
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
//       home: ShareAndEarnRulesScreen(),
//     );
//   }
// }