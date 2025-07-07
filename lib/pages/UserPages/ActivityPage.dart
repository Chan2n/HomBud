import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Make sure to import intl if you're using Timestamps
import 'BookingDetail.dart'; // Ensure this points to your actual BookingDetailPage file

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildBookingList("active")),
          Expanded(child: _buildBookingList("ongoing")),
          Expanded(child: _buildBookingList("completed")),
        ],
      ),
    );
  }

  Widget _buildBookingList(String status) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final documents = snapshot.data?.docs ?? [];
        if (documents.isEmpty) {
          return Center(child: Text('No $status bookings found'));
        }
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            return _buildBookingItem(documents[index]);
          },
        );
      },
    );
  }

  Widget _buildBookingItem(DocumentSnapshot document) {
    Map<String, dynamic> booking = document.data() as Map<String, dynamic>;

    return ListTile(
      leading: booking['imageUrls'] != null && (booking['imageUrls'] as List).isNotEmpty
          ? Image.network(booking['imageUrls'][0], width: 100, fit: BoxFit.cover)
          : null,
      title: Text(booking['fullName'] ?? 'No name'),
      // Adjust these lines based on your timestamp or string scenario:
      subtitle: Text('${booking['date'] != null ? (booking['date'] is Timestamp ? DateFormat('yyyy-MM-dd').format(booking['date'].toDate()) : booking['date']) : 'N/A'} at ${booking['time'] != null ? (booking['time'] is Timestamp ? DateFormat('h:mm a').format(booking['time'].toDate()) : booking['time']) : 'N/A'}'),
      trailing: Text(booking['status']),
      onTap: () {
        // Navigate to the BookingDetailPage with the booking details
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BookingDetailPage(booking: document),
        ));
      },
    );
  }
}
