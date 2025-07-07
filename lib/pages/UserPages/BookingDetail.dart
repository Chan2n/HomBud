import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class BookingDetailPage extends StatelessWidget {
  final DocumentSnapshot booking;

  const BookingDetailPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // You can access the booking details using booking.data() as Map
    Map<String, dynamic> details = booking.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(details['fullName'] ?? 'Booking Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display all booking details here
            // Check for null and display accordingly
            if (details['imageUrls'] != null && (details['imageUrls'] as List).isNotEmpty) ...[
              Image.network(details['imageUrls'][0], width: double.infinity, height: 200.0, fit: BoxFit.cover), // Displaying first image safely
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: ${details['fullName'] ?? 'N/A'}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Date: ${details['date'] != null ? DateFormat('yyyy-MM-dd').format(details['date'].toDate()) : 'N/A'}', style: const TextStyle(fontSize: 16)),
const SizedBox(height: 8),
Text('Time: ${details['time'] != null ? DateFormat('h:mm a').format(details['time'].toDate()) : 'N/A'}', style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 8),
                  Text('Details: ${details['details'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Landmark: ${details['landmark'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Payment: ${details['payment'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Price: ${details['price'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Status: ${details['status'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('User: ${details['user'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            // Add more fields as required
          ],
        ),
      ),
    );
  }
}
