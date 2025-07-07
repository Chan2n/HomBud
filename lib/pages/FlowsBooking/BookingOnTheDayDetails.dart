import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AcceptedDetails extends StatelessWidget {
  final Map<String, dynamic> data;

  const AcceptedDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> jobNames =
        data['jobName'].toString().split(',').map((job) => job.trim()).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Summary',
                  style: TextStyle(fontSize: 16),
                ),
                if (data['dateBooked'] != null)
                  Text(
                    'Date Booked: ${DateFormat('yyyy-MM-dd').format(data['dateBooked'].toDate())}',
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
            if (data['timeSlot'] != null)
              Text(
                'Time Slot: ${data['timeSlot']}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'Transaction ID: ${data['bookingID']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'lib/assets/images/Profile.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data['expertID'] !=
                        null) // Check if expertID is present
                      FutureBuilder<Map<String, dynamic>>(
                        future: _fetchExpertData(data['expertID']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text(
                              '\n Waiting for an Expert',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          Map<String, dynamic> expertData = snapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${expertData['FullName'] ?? 'Expert Name'}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${expertData['specializations'] ?? 'Specialization'}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    if (data['expertID'] ==
                        null) // Display when expertID is not present
                      const Text(
                        '\n Waiting for an Expert',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Items'), // Items
                Text('${jobNames.length}'), // Number of items (jobs)
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Services',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...jobNames.map<Widget>((job) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aircondition Services',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          job,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 100),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Location'),
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('User')
                        .doc(data['userID'])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('Location not found');
                      }

                      String locationName = 'Unknown';
                      if (snapshot.data!.exists &&
                          snapshot.data!['Location'] != null) {
                        locationName =
                            snapshot.data!['Location']['name'] ?? 'Unknown';
                      }

                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          locationName,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Item/s'),
                Text('${jobNames.length}'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Cost'),
                Text('PHP ${data['totalCost']}'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> _fetchExpertData(String expertID) async {
  try {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Expert')
        .where('ExpertID', isEqualTo: expertID)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final expertData = querySnapshot.docs.first.data();
      return expertData as Map<String, dynamic>;
    } else {
      return {};
    }
  } catch (e) {
    print('Error fetching expert data: $e');
    return {};
  }
}
