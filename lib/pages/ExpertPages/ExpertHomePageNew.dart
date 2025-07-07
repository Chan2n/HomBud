import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertAccount.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertDashboard.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertTodayBook.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertWallet.dart';
import 'package:intl/intl.dart';

class ExpertHomePage extends StatefulWidget {
  final String email;

  const ExpertHomePage({super.key, required this.email});

  @override
  _ExpertHomePageState createState() => _ExpertHomePageState();
}

class _ExpertHomePageState extends State<ExpertHomePage> {
  String expertID = ''; // Define expertID
  String fullName = '';
  int _selectedIndex = 2;
  Map<String, bool> jobDetailsVisibility = {};
  Map<String, bool> cardExpandedState = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFullName();
  }

  Future<void> fetchFullName() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Expert')
        .where('Email', isEqualTo: widget.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      setState(() {
        fullName = doc.get('FullName') ?? '';
        expertID = doc.get('ExpertID') ?? ''; // Ensure the field is fetched
        isLoading = false;
      });
      print('Fetched ExpertID: $expertID'); // Debug information
    } else {
      print('No documents found for the given email.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<DocumentSnapshot>> fetchBookings() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('bookings').get();
    return snapshot.docs;
  }

  Future<Map<String, dynamic>> fetchUserData(String userID) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('User').doc(userID).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  bool showJobDetails = false;
  String selectedJobName = '';
  double selectedJobCost = 0.0;

  void acceptJob(DocumentSnapshot bookingSnapshot) async {
    if (expertID.isNotEmpty) {
      await bookingSnapshot.reference.update({
        'status': 'accepted',
        'expertID': expertID, // Use the expert ID
      });

      setState(() {}); // Refresh the UI
    } else {
      print('Error: expertID is empty. Cannot accept job.');
    }
  }

  void declineJob(DocumentSnapshot bookingSnapshot) async {
    // Delete the declined booking from Firestore
    await bookingSnapshot.reference.delete();

    // Refresh UI by fetching updated bookings
    setState(() {});
  }

  Future<List<DocumentSnapshot>> fetchActiveBookings() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('status',
            isEqualTo: 'active') // Fetch bookings with status "active"
        .get();
    for (var doc in snapshot.docs) {
      jobDetailsVisibility[doc.id] =
          false; // Initialize visibility state for each job
      cardExpandedState[doc.id] = false; // Initialize card expanded state
    }
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> fetchTodayBookings() async {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('status', isEqualTo: 'accepted') // Only fetch accepted bookings
        .where(
          'dateBooked',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday),
          isLessThanOrEqualTo: Timestamp.fromDate(endOfToday),
        )
        .get();

    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> fetchAcceptedBookings() async {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    DateTime startOfTomorrow =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
    DateTime endOfTomorrow =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59, 59);

    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('status', isEqualTo: 'accepted') // Fetch only accepted bookings
        .where(
          'dateBooked',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfTomorrow),
          isLessThanOrEqualTo: Timestamp.fromDate(endOfTomorrow),
        )
        .get();

    return snapshot.docs;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Navigate to Account Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertAccount(email: widget.email),
          ),
        );
        break;
      case 1:
        // Navigate to Wallet Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertWallet(email: widget.email),
          ),
        );
        break;
      case 2:
        // Stay on My Jobs Page
        break;
      case 3:
        // Navigate to Dashboard Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(email: widget.email),
          ),
        );
        break;
      case 4:
        // Navigate to Message Page
        Navigator.pushNamed(context, '/expertHome', arguments: widget.email);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(now);
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white, // Set the background color to pure white
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF0067A5), // Change the color to blue
                        ),
                        textAlign: TextAlign.center, // Center align the text
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Ma\'ayong Adlaw,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        fullName.isNotEmpty ? fullName : 'Loading...',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder<List<DocumentSnapshot>>(
                        future: fetchActiveBookings(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            // Display a logo indicating "Off Duty"
                            return Center(
                              child: Image.asset(
                                'lib/assets/images/Offduty.png', // Path to your off duty logo image
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                fit: BoxFit.contain,
                              ),
                            );
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> booking =
                                    document.data() as Map<String, dynamic>;
                                return FutureBuilder<Map<String, dynamic>>(
                                  future: fetchUserData(booking['userID']),
                                  builder: (context, userSnapshot) {
                                    if (userSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (!userSnapshot.hasData) {
                                      return const Text("User data not found.");
                                    }

                                    Map<String, dynamic> userData =
                                        userSnapshot.data!;

                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TodayDetails(
                                                  data: booking,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        DateFormat(
                                                                'EEEE, MMMM d, yyyy')
                                                            .format(booking[
                                                                        'dateBooked']
                                                                    ?.toDate() ??
                                                                DateTime.now()),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF0067A5),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        booking['time'] ?? '',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF0067A5),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        booking['timeSlot'] ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF0067A5),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const SizedBox(width: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userData[
                                                                  'fullName'] ??
                                                              'Name Placeholder',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          userData['Location'] !=
                                                                  null
                                                              ? userData['Location']
                                                                      [
                                                                      'name'] ??
                                                                  'Address Placeholder'
                                                              : 'Address Placeholder',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            cardExpandedState[
                                                                    document
                                                                        .id] =
                                                                !(cardExpandedState[
                                                                        document
                                                                            .id] ??
                                                                    false);
                                                          });
                                                        },
                                                        child: Text(
                                                          booking['service'] ??
                                                              'Repair and Maintenance Services',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (cardExpandedState[
                                                        document.id] ??
                                                    false) ...[
                                                  const SizedBox(height: 3),
                                                  Text(
                                                      'Job Name: ${booking['jobName']}'),
                                                  Text(
                                                      'Price: \$${booking['totalCost'] ?? 0.0}'),
                                                ],
                                                const SizedBox(height: 3),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await fetchFullName();
                                                        if (expertID
                                                            .isNotEmpty) {
                                                          acceptJob(document);
                                                        } else {
                                                          print(
                                                              'Error: expertID is empty.');
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF003B5F), // Button color
                                                        foregroundColor: Colors
                                                            .white, // Text color
                                                      ),
                                                      child:
                                                          const Text('Accept'),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        declineJob(document);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor: Colors
                                                            .black, // Text color
                                                        backgroundColor: Colors
                                                            .white, // Button background color stays same
                                                      ),
                                                      child:
                                                          const Text('Decline'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                      ],
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20), // Ensure space is maintained
                      const Text(
                        'Jobs Today',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      FutureBuilder<List<DocumentSnapshot>>(
                        future:
                            fetchTodayBookings(), // Updated future function to fetch active bookings
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text("No active bookings found.");
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> booking =
                                    document.data() as Map<String, dynamic>;
                                return FutureBuilder<Map<String, dynamic>>(
                                  future: fetchUserData(booking['userID']),
                                  builder: (context, userSnapshot) {
                                    if (userSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (!userSnapshot.hasData) {
                                      return const Text("User data not found.");
                                    }

                                    Map<String, dynamic> userData =
                                        userSnapshot.data!;

                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TodayDetails(
                                                  data: booking,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      // Assuming 'booking['date']' is a Timestamp field
                                                      '${DateFormat('EEEE, MMMM d, yyyy').format(booking['dateBooked']?.toDate() ?? DateTime.now())} ' +
                                                          (booking['time'] ??
                                                              '') +
                                                          ' ' +
                                                          (booking[
                                                                  'timeSlot'] ??
                                                              ''),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF0067A5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const SizedBox(width: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors
                                                            .grey, // Background color of the avatar
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'lib/assets/images/Profile.png', // Path to your image asset
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      // Wrap the name and location in a Column
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userData[
                                                                  'fullName'] ??
                                                              'Name Placeholder',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          userData['Location'] !=
                                                                  null
                                                              ? userData['Location']
                                                                      [
                                                                      'name'] ??
                                                                  'Address Placeholder'
                                                              : 'Address Placeholder',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            cardExpandedState[
                                                                    document
                                                                        .id] =
                                                                !(cardExpandedState[
                                                                        document
                                                                            .id] ??
                                                                    false);
                                                          });
                                                        },
                                                        child: Text(
                                                          booking['service'] ??
                                                              'Repair and Maintenance Services',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width:
                                                              5), // Add some space between the text and the icon
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (cardExpandedState[
                                                        document.id] ??
                                                    false) ...[
                                                  const SizedBox(height: 3),
                                                  Text(
                                                      'Job Name: ${booking['jobName']}'),
                                                  Text(
                                                      'Price: \$${booking['totalCost'] ?? 0.0}'),
                                                ],
                                                const SizedBox(height: 3),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                      ],
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20), // Ensure space is maintained
                      const Text(
                        'Upcoming Jobs',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<DocumentSnapshot>>(
                        future:
                            fetchAcceptedBookings(), // Updated future function to fetch active bookings
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text("No active bookings found.");
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> booking =
                                    document.data() as Map<String, dynamic>;
                                return FutureBuilder<Map<String, dynamic>>(
                                  future: fetchUserData(booking['userID']),
                                  builder: (context, userSnapshot) {
                                    if (userSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (!userSnapshot.hasData) {
                                      return const Text("User data not found.");
                                    }

                                    Map<String, dynamic> userData =
                                        userSnapshot.data!;

                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cardExpandedState[document.id] =
                                                  !(cardExpandedState[
                                                          document.id] ??
                                                      false);
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      // Assuming 'booking['date']' is a Timestamp field
                                                      DateFormat(
                                                              'EEEE, MMMM d, yyyy')
                                                          .format(booking[
                                                                      'dateBooked']
                                                                  ?.toDate() ??
                                                              DateTime.now()),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF0067A5),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 40),
                                                    Text(
                                                      // Assuming 'booking['time']' is also intended to be formatted
                                                      // If 'time' is actually a string and not a Timestamp, leave it as is
                                                      booking['time'] ?? '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF0067A5),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    Text(
                                                      booking['timeSlot'] ?? '',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF0067A5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const SizedBox(width: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors
                                                            .grey, // Background color of the avatar
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'lib/assets/images/Profile.png', // Path to your image asset
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      // Wrap the name and location in a Column
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userData[
                                                                  'fullName'] ??
                                                              'Name Placeholder',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          userData['Location'] !=
                                                                  null
                                                              ? userData['Location']
                                                                      [
                                                                      'name'] ??
                                                                  'Address Placeholder'
                                                              : 'Address Placeholder',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            cardExpandedState[
                                                                    document
                                                                        .id] =
                                                                !(cardExpandedState[
                                                                        document
                                                                            .id] ??
                                                                    false);
                                                          });
                                                        },
                                                        child: Text(
                                                          booking['service'] ??
                                                              'Repair and Maintenance Services',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width:
                                                              5), // Add some space between the text and the icon
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (cardExpandedState[
                                                        document.id] ??
                                                    false) ...[
                                                  const SizedBox(height: 3),
                                                  Text(
                                                      'Job Name: ${booking['jobName']}'),
                                                  Text(
                                                      'Price: \$${booking['totalCost'] ?? 0.0}'),
                                                ],
                                                const SizedBox(height: 3),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                      ],
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        color: Colors.white, // Set the background color to pure white
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _onItemTapped(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Account.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      'Account',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onItemTapped(1);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Wallet.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      'Wallet',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onItemTapped(2);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/MyJobs.png',
                      width: 60,
                      height: 30,
                    ),
                    Text(
                      'My Jobs',
                      style: TextStyle(
                        color: _selectedIndex == 2 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onItemTapped(3);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Dashboard.png',
                      width: 60,
                      height: 30,
                    ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: _selectedIndex == 3 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onItemTapped(4);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 4 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Message.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      'Message',
                      style: TextStyle(
                        color: _selectedIndex == 4 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
