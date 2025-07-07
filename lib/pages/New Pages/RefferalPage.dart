import 'package:flutter/material.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  bool isOverlayVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Screen'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Picture taking half the screen
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.asset(
                    'lib/assets/img_23.png', // Adjust image path
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                // Share app to friends and HB Rewards section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildListItem(Icons.person_add, 'Share app', 'to friends'),
                    const Icon(Icons.arrow_forward, size: 20), // Smaller arrow
                    _buildListItem(Icons.arrow_forward, 'to Friends Register', ''),
                    const Icon(Icons.arrow_forward, size: 20), // Smaller arrow
                    _buildListItem(Icons.arrow_forward, 'to HB Rewards', ''),
                  ],
                ),
                // Share and earn rules
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'Share and earn rules',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // Start sharing text
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Start sharing',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Text box with borders and copy button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), // Black border
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your referral code',
                              border: InputBorder.none, // Remove TextField border
                              contentPadding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Copy referral code functionality
                        },
                        style: ElevatedButton.styleFrom(
                          // Black text
                          side: const BorderSide(color: Colors.black), // Black border
                        ),
                        child: const Text('Copy'),
                      ),
                    ],
                  ),
                ),
                // Share button with purple background
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Share functionality
                      setState(() {
                        isOverlayVisible = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      // Purple background
                    ),
                    child: const Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.white, // Change the color to your desired color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isOverlayVisible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isOverlayVisible = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width, // Match screen width
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'lib/assets/img_28.png', // Adjust image path
                            width: 100, // Adjust image size
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Share with Friends',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'I found a solution for my home needs',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'lib/assets/img_29.png',
                                width: 40, // Adjust icon size as needed
                                height: 40,
                              ),
                              Image.asset(
                                'lib/assets/img_30.png',
                                width: 40,
                                height: 40,
                              ),
                              Image.asset(
                                'lib/assets/img_31.png',
                                width: 40,
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon),
        Text(title),
        Text(subtitle),
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
//       home: ShareScreen(),
//     );
//   }
// }
