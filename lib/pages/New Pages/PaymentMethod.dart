import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Image.asset('lib/assets/img.png', width: 50, height: 50),
          // Logo at the right
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 5),
            const Text(
              'You will only be charged after the service. You can change this after every booked service/s',
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Currently Linked',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // List of payment methods
            _buildPaymentMethods(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    List<Map<String, dynamic>> paymentMethods = [
      {'name': 'PNB', 'icon': Icons.account_balance, 'linked': true},
      {'name': 'GCash', 'icon': Icons.monetization_on, 'linked': true},
      {'name': 'Other Methods'},
      {'name': 'Cash', 'icon': Icons.money, 'subtitle': 'Pay directly to the Service Provider'},
      {'name': 'PayMaya', 'icon': Icons.credit_card},
      {'name': 'Credit/Debit Card', 'icon': Icons.credit_card},
      {'name': 'Bank Account', 'icon': Icons.account_balance},
    ];

    return Column(
      children: paymentMethods.map((method) {
        if (method['name'] == 'Other Methods') {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              method['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        } else {
          bool linked = method['linked'] ?? false; // Handle absence of 'linked' key
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (method['icon'] != null) ...[
                      Icon(method['icon']),
                      const SizedBox(width: 10),
                    ],
                    Text(
                      method['name'],
                      style: TextStyle(
                        fontWeight: linked ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (method.containsKey('subtitle')) // Add subtitle if available
                  Text(
                    method['subtitle'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                // Placeholder for linked indicator
                  const Icon(Icons.arrow_forward_ios, color: Colors.green, size: 20),
              ],
            ),
          );
        }

      }).toList(),
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
//       home: PaymentMethodScreen(),
//     );
//   }
// }
