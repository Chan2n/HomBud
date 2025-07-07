import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hombuddy/main.dart';
import 'package:hombuddy/pages/FlowsUser/UserActivity.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class TodayBooking extends StatefulWidget {
  final String bookingId;
  final UserModel loggedInUser;

  const TodayBooking(
      {super.key, required this.bookingId, required this.loggedInUser});

  @override
  _TodayBookingState createState() => _TodayBookingState();
}

class _TodayBookingState extends State<TodayBooking> {
  String? expertId;

  @override
  void initState() {
    super.initState();

    // Listen to changes in the booking document
    FirebaseFirestore.instance
        .collection('bookings')
        .doc(widget.bookingId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          expertId = snapshot['expertID'];
          String status = snapshot['status'];
          if (status == 'accepted' &&
              expertId != null &&
              expertId!.isNotEmpty) {
            // Fetch the expert name and navigate to view more
            FirebaseFirestore.instance
                .collection('Expert')
                .doc(expertId)
                .get()
                .then((expertSnapshot) {
              if (expertSnapshot.exists) {
                String expertName = expertSnapshot['FullName'] ?? 'Unknown';
                _showNotification('Booking Accepted',
                    'Your booking has been accepted by $expertName');
                _navigateToViewMore(context, expertName);
              }
            });
          }
        });
      }
    });
  }

  Future<void> _showNotification(String title, String body) async {
    print('Showing notification: $title - $body');

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'booking_channel', // Unique ID for the notification channel
      'Booking Notifications', // Name for the notification channel
      channelDescription:
          'Notifications for booking status updates', // Description for the notification channel
      importance: Importance.max, // Set the importance level to maximum
      priority: Priority.high, // Set the priority level to high
      showWhen: true, // Show the timestamp
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID, can be used to update or cancel the notification later
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics, // Notification details
      payload: 'item x', // Optional payload data
    );
  }

  void _navigateToViewMore(BuildContext context, String expertName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme:
                const DialogThemeData(backgroundColor: Colors.transparent),
          ),
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('lib/assets/images/Profile.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your booking has been accepted by',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        expertName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserActivity(user: widget.loggedInUser),
                              ),
                            );
                          },
                          child: const Text(
                            'Proceed to Activity',
                            style: TextStyle(color: Colors.white),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFF0067A5),
              Color(0xFF00273F),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              const Text(
                "Hold On Tight",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "We are Looking for the\n   right Expert for you!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'lib/assets/images/OnTheDay.png',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
