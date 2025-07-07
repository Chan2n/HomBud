import 'package:flutter/material.dart';

class BannerNotification extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  final double distance;
  final VoidCallback onMessagePressed; // Add a callback for message press

  const BannerNotification({
    super.key,
    required this.message,
    required this.onClose,
    required this.distance,
    required this.onMessagePressed, // Initialize the callback
  });

  @override
  Widget build(BuildContext context) {
    String imageAsset;
    if (distance > 50) {
      imageAsset = 'lib/assets/images/Moving1.png';
    } else if (distance > 40) {
      imageAsset = 'lib/assets/images/Moving2.png';
    } else if (distance > 30) {
      imageAsset = 'lib/assets/images/Moving3.png';
    } else if (distance > 25) {
      imageAsset = 'lib/assets/images/Moving4.png';
    } else if (distance > 10) {
      imageAsset = 'lib/assets/images/Moving5.png';
    } else if (distance > 5) {
      imageAsset = 'lib/assets/images/Moving6.png';
    } else {
      imageAsset = 'lib/assets/images/Moving7.png';
    }

    return Material(
      color: Colors.transparent,
      child: distance <= 3
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Your HomBuddy Expert is here! Please let us know if this is the correct Expert for your service. Click to Confirm.",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.black),
                        onPressed: onMessagePressed, // Use the callback
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.black),
                        onPressed: () {
                          // Add your call logic here
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // Adjust the opacity here
                borderRadius: BorderRadius.circular(1),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: onClose,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80, // Set the height of the image container
                    child: Image.asset(imageAsset, fit: BoxFit.fill),
                  ),
                ],
              ),
            ),
    );
  }
}
