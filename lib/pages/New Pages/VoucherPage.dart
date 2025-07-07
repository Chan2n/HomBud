import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100, // Decreased the height of the blue background
              child: Container(
                color: Colors.lightBlue[200], // Columbia blue color
                padding: const EdgeInsets.symmetric(vertical: 10), // Adjusted vertical padding
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        'lib/assets/img_23.png', // Adjust the asset path as per your project structure
                        width: 150, // Increased logo width
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                           // Change the color to white
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'HB Deals',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20, // Decreased font size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Voucher boxes
            _buildVoucherBox(context, '[LIMITED TIME] P100 OFF', 'lib/assets/img_24.png', 'Minimum spend P660'), // Adjust asset paths
            const SizedBox(height: 20),
            _buildVoucherBox(context, '[BETA] P100 OFF', 'lib/assets/img_25.png', 'Minimum spend P550'),
            const SizedBox(height: 20),
            _buildVoucherBox(context, '20% OFF, 8AM - 9AM', 'lib/assets/img_26.png', 'Minimum spend P3000'),
            const SizedBox(height: 20),
            _buildVoucherBox(context, '[LIMITED TIME] P100 OFF', 'lib/assets/img_24.png', 'Minimum spend P660'),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherBox(BuildContext context, String title, String imagePath, String additionalText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Gray color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 80, // Adjust image width as needed
            height: 80, // Adjust image height as needed
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  additionalText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
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
//       home: VoucherPage(),
//     );
//   }
// }
