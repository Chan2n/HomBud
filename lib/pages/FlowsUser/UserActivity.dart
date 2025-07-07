import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccount.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';
import 'package:hombuddy/pages/FlowsUser/UserMessage.dart';
import 'package:hombuddy/pages/FlowsUser/UserPayment.dart';
import 'package:hombuddy/pages/FlowsUser/UserViewMore.dart';
import 'package:intl/intl.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class UserActivity extends StatefulWidget {
  final UserModel user;

  const UserActivity({super.key, required this.user});

  @override
  _UserActivityState createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserActivity(user: widget.user)),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserPayment(user: widget.user)),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserHomePage(user: widget.user)),
          );
          break;
        case 3:
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Work in Progress'),
                content:
                    const Text('This feature is currently under development.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserAccount(user: widget.user)),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'User Activity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Image.asset(
            'lib/assets/images/BookingLogo.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('userID', isEqualTo: widget.user.idNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No bookings found'),
            );
          }

          List<DocumentSnapshot> ongoingBookings = [];
          List<DocumentSnapshot> recentBookings = [];

          // Categorize bookings into ongoing and recent based on date
          DateTime now = DateTime.now();
          for (var document in snapshot.data!.docs) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            DateTime? dateBooked;
            String status = '';
            try {
              dateBooked = (data['dateBooked'] as Timestamp?)?.toDate();
              status = data['status'] ?? '';
            } catch (e) {
              print('Error parsing booking data: $e');
            }

            if (dateBooked != null) {
              if ((status == 'accepted' || dateBooked.isAfter(now))) {
                ongoingBookings.add(document);
              } else {
                recentBookings.add(document);
              }
            }
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection('Ongoing', ongoingBookings),
                _buildSection('Recent', recentBookings),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Activity.png',
              'Activity',
              0,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserActivity(user: widget.user),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Wallet.png',
              'Payment',
              1,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPayment(user: widget.user),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Hombuddynav.png',
              '',
              2,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHomePage(user: widget.user),
                ),
              ),
              isMain: true,
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Message.png',
              'Message',
              3,
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserMessagingPage(
                        expertID: "EXPERT_ID_HERE",
                        user: widget
                            .user), // Replace "EXPERT_ID_HERE" with the actual expert ID
                  ),
                );
              },
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Account.png',
              'Account',
              4,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAccount(user: widget.user),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(BuildContext context, String iconPath,
      String label, int index, VoidCallback onTap,
      {bool isMain = false}) {
    return GestureDetector(
      onTap: () {
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
          onTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70, // Fix width for the container
        child: ClipPath(
          clipper: PointyTopClipper(),
          child: Container(
            color: _selectedIndex == index
                ? const Color(0xFF0067A5)
                : Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(
                    decoration: isMain
                        ? BoxDecoration(
                            color: const Color(0xFF0067A5),
                            borderRadius: BorderRadius.circular(15),
                          )
                        : null,
                    padding: isMain ? const EdgeInsets.all(8) : EdgeInsets.zero,
                    child: Image.asset(
                      iconPath,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                if (label.isNotEmpty)
                  Text(
                    label,
                    style: TextStyle(
                      color: _selectedIndex == index ? Colors.white : null,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<DocumentSnapshot> bookings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (bookings.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = bookings[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String status = data['status'] ?? '';
              // Convert timestamp to DateTime
              DateTime? dateBooked;
              try {
                dateBooked = (data['dateBooked'] as Timestamp?)?.toDate();
              } catch (e) {
                dateBooked = null;
                print('Error parsing dateBooked: $e');
              }
              if (dateBooked == null) {
                return const SizedBox(); // Skip invalid entries
              }

              // Format the date
              String formattedDate = DateFormat.yMMMMd().format(dateBooked);
              String formattedTime = DateFormat.jm().format(dateBooked);

              return GestureDetector(
                onTap: () {
                  // Detailed logging for data being passed to ViewMore
                  print('Navigating to ViewMore with data:');
                  data.forEach((key, value) {
                    print('$key: $value (${value.runtimeType})');
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMore(
                              data: data,
                              user: widget.user,
                            )),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            data['Aircondition'] ?? 'Airconditioning Services',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 60),
                          Text('Php ${data['totalCost'].toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 60),
                          Text(formattedTime),
                          const SizedBox(width: 50),
                          const Text(
                            'View More',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
