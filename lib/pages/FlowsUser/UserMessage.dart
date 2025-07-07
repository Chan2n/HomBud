import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccount.dart';
import 'package:hombuddy/pages/FlowsUser/UserActivity.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:hombuddy/pages/FlowsUser/UserPayment.dart';

class UserMessagingPage extends StatefulWidget {
  final String expertID;
  final UserModel user;

  const UserMessagingPage(
      {super.key, required this.expertID, required this.user});

  @override
  _UserMessagingPageState createState() => _UserMessagingPageState();
}

class _UserMessagingPageState extends State<UserMessagingPage> {
  int _selectedIndex = 3;

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
          // Do nothing, already on the messaging page
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
        title: const Text('Chat with Expert'),
      ),
      body: Center(
        child: Image.asset(
          'lib/assets/images/Messagepic.png', // Replace with your image path
          fit: BoxFit.cover, // Adjust the fit as needed
        ),
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
              () => _onItemTapped(0),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Wallet.png',
              'Payment',
              1,
              () => _onItemTapped(1),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Hombuddynav.png',
              '',
              2,
              () => _onItemTapped(2),
              isMain: true,
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Message.png',
              'Message',
              3,
              () => _onItemTapped(3),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Account.png',
              'Account',
              4,
              () => _onItemTapped(4),
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
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70,
        child: ClipPath(
          clipper: PointyTopClipperr(),
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
}

class PointyTopClipperr extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double roundnessFactor =
        10.0; // Adjust this value to control the roundness of the bottom corners
    Path path = Path();

    path.moveTo(size.width * 0.5, 0); // Top center (pointy part)
    path.lineTo(0, size.height * 0.3); // Left side of the box
    path.lineTo(
        0,
        size.height -
            roundnessFactor); // Move to bottom left with straight line
    path.quadraticBezierTo(0, size.height, roundnessFactor,
        size.height); // Bottom left rounded corner

    path.lineTo(size.width - roundnessFactor,
        size.height); // Move to bottom right with straight line
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - roundnessFactor); // Bottom right rounded corner

    path.lineTo(size.width, size.height * 0.3); // Right side of the box
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
