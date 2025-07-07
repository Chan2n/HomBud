import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/UserBanner.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:math';

import 'FinalRatings.dart';
import 'ChatScreen.dart';
import 'UserModel.dart';

class ViewMore extends StatefulWidget {
  final Map<String, dynamic> data;
  final UserModel user;

  const ViewMore({super.key, required this.data, required this.user});

  @override
  _ViewMoreState createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  bool showBanner = false;
  double distance = 0.0; // Variable to store the distance
  bool showArrivalModal = false; // Flag to show the modal only once
  String mainButtonText = "Track Expert";
  bool showBottomButtons = false;
  String? documentId;

  @override
  void initState() {
    super.initState();
    _getDocumentId();
    _checkIfTodayBooking();
    _fetchUserLocationAndExpertLocation();
  }

  Future<void> _getDocumentId() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('bookingID', isEqualTo: widget.data['bookingID'].toString())
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        documentId = querySnapshot.docs.first.id;
      });
      _addBookingStatusListener(); // Add the listener after getting the document ID
    }
  }

  void _addBookingStatusListener() {
    if (documentId != null) {
      FirebaseFirestore.instance
          .collection('bookings')
          .doc(documentId)
          .snapshots()
          .listen((snapshot) {
        final bookingData = snapshot.data();
        if (bookingData != null && bookingData['status'] == 'finished') {
          _showCompletionDialog();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkIfTodayBooking() {
    DateTime today = DateTime.now();
    DateTime? bookingDate;
    try {
      bookingDate = (widget.data['dateBooked'] as Timestamp?)?.toDate();
    } catch (e) {
      print('Error parsing dateBooked: $e');
      bookingDate = null;
    }
    bool isTodayBooking = bookingDate != null &&
        today.year == bookingDate.year &&
        today.month == bookingDate.month &&
        today.day == bookingDate.day;

    if (isTodayBooking && widget.data['status'] == 'accepted') {
      setState(() {
        showBanner = true;
      });
    }
  }

  Future<void> _fetchUserLocationAndExpertLocation() async {
    if (widget.data['expertID'] != null) {
      final expertDoc = await FirebaseFirestore.instance
          .collection('Expert')
          .doc(widget.data['expertID'])
          .get();

      final userDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.user.idNumber)
          .get();

      if (expertDoc.exists &&
          expertDoc.data() != null &&
          userDoc.exists &&
          userDoc.data() != null) {
        final expertLocation = expertDoc.data()!['Location'];
        final userLocation = userDoc.data()!['Location'];

        if (expertLocation != null && userLocation != null) {
          double expertLat = _convertToDouble(expertLocation['latitude']);
          double expertLng = _convertToDouble(expertLocation['longitude']);
          double userLat = _convertToDouble(userLocation['latitude']);
          double userLng = _convertToDouble(userLocation['longitude']);

          double calculatedDistance =
              calculateDistance(userLat, userLng, expertLat, expertLng);

          if (widget.data['status'] == 'accepted') {
            setState(() {
              distance = calculatedDistance;
              _checkProximity(distance);
            });
          }
        }
      }
    }
  }

  double _convertToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      throw Exception('Invalid type for latitude/longitude');
    }
  }

  void _checkProximity(double distance) {
    if (distance <= 2.0 && !showArrivalModal) {
      // Assuming 2 meters is the threshold
      setState(() {
        showArrivalModal = true;
      });
      _showArrivalDialog();
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Pi/180
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  void _openChatScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
            userId: widget.user.idNumber,
            expertId:
                widget.data['expertID'], // Pass the expertID to ChatScreen
            isExpert: false), // User is not the expert
      ),
    );
  }

  void _showArrivalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Your Safety is Our Priority"),
          content: const Text(
              "Confirm below if the Expert for your service has arrived. Otherwise, you may contact Support so we may get in touch with the Expert's location."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add any additional actions for confirming expert arrival here
              },
              child: const Text("Confirm Expert"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add any additional actions for contacting support here
              },
              child: const Text("Contact Support"),
            ),
          ],
        );
      },
    );
  }

  Color veryBrightWhite = const Color(0xFFFFFFFF); // Full opacity white

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: veryBrightWhite,
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/images/Appir.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Booking Completed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003B5F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Expert has completed the booked services',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'I understand payment will be credited to my account.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalRatings(
                        expertId: widget.data['expertID'],
                        bookingId: widget.data['bookingID'].toString(),
                        user: widget.user,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF003B5F),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Rate Expert',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> jobNames = widget.data['jobName']
        .toString()
        .split(',')
        .map((job) => job.trim())
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        ' ',
                        style: TextStyle(fontSize: 1),
                      ),
                      if (widget.data['dateBooked'] != null)
                        Text(
                          '      ${DateFormat('yyyy-MM-dd').format((widget.data['dateBooked'] as Timestamp).toDate())}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                  if (widget.data['timeSlot'] != null)
                    Text(
                      ' ${widget.data['timeSlot']}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
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
                      'Transaction ID: ${widget.data['bookingID'].toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height:
                              10), // Add some space between the text and the container
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
                              if (widget.data['expertID'] !=
                                  null) // Check if expertID is present
                                FutureBuilder<Map<String, dynamic>>(
                                  future:
                                      _fetchExpertData(widget.data['expertID']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text(
                                        '\n Waiting for an Expert',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> expertData =
                                        snapshot.data!;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${expertData['FullName'] ?? 'Expert Name'}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${expertData['specializations'] ?? 'Expert Location'}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              if (widget.data['expertID'] ==
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
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              return const Text('Location not found');
                            }

                            String location = snapshot.data?['Location']
                                    ?['name'] ??
                                'Unknown';

                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Text(
                                location,
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
                      const Text('Total Fee'),
                      Text('PHP ${widget.data['totalCost']}'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleConfirmBooking,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF003B5F),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Complete Booking',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showBanner && widget.data['status'] == 'accepted')
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: BannerNotification(
                message:
                    'Our HomeBuddy Expert is on the Way!\nEstimated Time of Arrival: •• mins away',
                onClose: () {
                  setState(() {
                    showBanner = false;
                  });
                },
                distance: distance, // Pass the distance to the banner
                onMessagePressed: _openChatScreen, // Pass the callback here
              ),
            ),
          if (showArrivalModal) _buildArrivalModal(context),
        ],
      ),
    );
  }

  Widget _buildArrivalModal(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black54, // Semi-transparent background
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Your Safety is Our Priority",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Confirm below if the Expert for your service has arrived. Otherwise, you may contact Support so we may get in touch with the Expert's location.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showArrivalModal = false;
                        });
                        // Handle Confirm Expert action
                      },
                      child: const Text("Confirm Expert"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showArrivalModal = false;
                        });
                        // Handle Contact Support action
                      },
                      child: const Text("Contact Support"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchExpertData(String expertID) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Expert')
          .where('ExpertID', isEqualTo: expertID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final expertData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        return expertData;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching expert data: $e');
      return {};
    }
  }

  Future<void> _handleConfirmBooking() async {
    print('Confirm Booking button clicked');

    final status = widget.data['status'];
    print('Booking status: $status');

    if (status == 'finished') {
      _showCompletionDialog();
    } else if (status == 'accepted') {
      _showErrorDialog(
          'You can only confirm when the Expert completes the booking.');
    } else {
      _showErrorDialog('The booking is not yet completed.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Wait for Expert to Confirm"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
