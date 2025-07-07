import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hombuddy/pages/ExpertPages/ExpertMaps.dart';

class TodayDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const TodayDetails({super.key, required this.data});

  @override
  _TodayDetailsState createState() => _TodayDetailsState();
}

class _TodayDetailsState extends State<TodayDetails> {
  bool showBottomButtons = false;
  String mainButtonText = "Going";
  String bookingStatus = '';
  bool hasClickedGoing = false; // Track whether "Going" has been clicked

  @override
  void initState() {
    super.initState();
    _fetchBookingStatus();
  }

  Future<void> _fetchBookingStatus() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('bookingID', isEqualTo: widget.data['bookingID'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        DocumentSnapshot bookingDoc = await FirebaseFirestore.instance
            .collection('bookings')
            .doc(documentId)
            .get();

        setState(() {
          bookingStatus = bookingDoc['status'];
        });
      }
    } catch (e) {
      print('Failed to fetch booking status: $e');
    }
  }

  Future<bool> _updateStatus(String newStatus) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('bookingID', isEqualTo: widget.data['bookingID'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(documentId)
            .update({'status': newStatus});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated to $newStatus')),
        );

        return true; // Indicate success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking not found')),
        );
        return false; // Indicate failure
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
      return false; // Indicate failure
    }
  }

  void _showWaitingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Waiting for User Confirmation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleMainButtonPress() async {
    if (mainButtonText == "Going") {
      setState(() {
        mainButtonText = "Add Ons"; // Update button text to "Add Ons"
        hasClickedGoing = true; // Track that the button has been clicked
        showBottomButtons = true; // Show bottom buttons
      });
      // Navigate to MapScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            userID: widget.data['userID'],
            expertID: widget.data['expertID'],
          ),
        ),
      );
    } else if (mainButtonText == "Add Ons") {
      // Show Help Center dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Center(
              child: Text(
                'Help Center',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Good News\n',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Buddy would like to add services on top of current one',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(
                        0xFF003B5F), // Match the "Add Ons" button color
                  ),
                  child: const Text('Request for an additional order override'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> jobNames = widget.data['jobName']
        .toString()
        .split(',')
        .map((job) => job.trim())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Booking'),
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
                'Transaction ID: ${widget.data['bookingID']}',
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
                    if (widget.data['userID'] != null)
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('User')
                            .doc(widget.data['userID'])
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Text(
                              '\n Waiting for User Data',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }

                          Map<String, dynamic> userData =
                              snapshot.data!.data() ?? {};

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userData['fullName'] ?? 'User Name'}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${userData['Location'] != null ? userData['Location']['name'] ?? 'Location' : 'Unknown Location'}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    if (widget.data['userID'] == null)
                      const Text(
                        '\n Waiting for User Data',
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
                const Text('Items'),
                Text('${jobNames.length}'),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Services',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                const SizedBox(height: 12),
                ...jobNames.map<Widget>((job) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aircondition Services',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
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
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('User')
                        .doc(widget.data['userID'])
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
                Text('PHP ${widget.data['totalCost']}'),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _handleMainButtonPress,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF003B5F), // Text color
                ),
                child: Text(mainButtonText),
              ),
            ),
            if (showBottomButtons)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _updateStatus(
                                'incomplete'); // Update status to 'incomplete'
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: const Center(
                                    child: Text(
                                      'Incomplete Booking',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch, // Make column take full width
                                    children: [
                                      const SizedBox(height: 8),
                                      const Center(
                                        child: Text(
                                          'Expert is unable to complete booked services due to homeowner-related issues',
                                          textAlign: TextAlign
                                              .center, // Center the text
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        'Reason for Incompletion:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const TextField(
                                        maxLines:
                                            5, // Adjust size of the text field
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter the reason here...',
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                            // Handle additional actions if needed
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: const Color(
                                                0xFF003B5F), // Match the previous button color
                                          ),
                                          child: const Text('Confirm'),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color.fromARGB(
                                255, 218, 213, 213), // Background color
                          ),
                          child: const Text(
                            'Booking Incomplete',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _updateStatus(
                                'finished'); // Update status to 'finished'
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color(0xFF003B5F), // Text color
                          ),
                          child: const Text(
                            'Booking Complete',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
