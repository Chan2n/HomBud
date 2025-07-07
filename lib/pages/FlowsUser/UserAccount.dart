import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow5.1.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountChange.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountHelpCenter.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountSaveLocation.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountSettings.dart';
import 'package:hombuddy/pages/FlowsUser/UserActivity.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow1.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';
import 'package:hombuddy/pages/FlowsUser/UserMessage.dart';

import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:hombuddy/pages/FlowsUser/UserPayment.dart';

class UserAccount extends StatefulWidget {
  final UserModel user;

  const UserAccount({super.key, required this.user});

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'lib/assets/images/BookingLogo.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 70),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            AssetImage('lib/assets/images/Profile.png'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget
                                .user.fullName, // Using fullName from UserModel
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0067A5),
                            ),
                          ),
                          Text(
                            widget.user
                                .mobileNumber, // Using mobileNumber from UserModel
                            style: const TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserAccountChange(
                                    user: widget.user,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF0067A5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => _BankAccount(context,
                    widget.user), // Pass context and user to _BankAccount
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con1.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Manage Linked Bank Accounts',
                          style: TextStyle(
                            color: Color(0xFF0067A5),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con2.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'My Rewards', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _savelocation(context, widget.user);
                },
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con3.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Saved Locations', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _Setting(context),
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con4.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Settings', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con5.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Chat with Hombuddy', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _HelpCenterr(context),
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con6.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Help Center', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _TOC(context),
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con7.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Terms and Conditions', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _TOC(context),
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con8.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Privacy Policy', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Add the image here
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con9.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      // Add the text
                      const Expanded(
                        child: Text(
                          'Become an Expert', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the left
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _logout(context),
                child: Container(
                  width: 360,
                  height: 40,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // Set Margin Here
                  // Align the container's content to the center
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue), // Add border
                    borderRadius:
                        BorderRadius.circular(10), // Add border radius
                  ),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10), // Add padding
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'lib/assets/images/con10.png', // Replace 'path_to_your_image' with your image path
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                          // You can also add other properties like fit, alignment, etc., as needed
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Logout', // Text inside the container
                          style: TextStyle(
                            color: Color(0xFF0067A5), // Set text color to blue
                          ),
                          // Align text to the center
                          textAlign: TextAlign.left,
                        ),
                      ),
                      // Add the ">" icon
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue, // Set icon color to blue
                        size: 16, // Adjust icon size as needed
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Activity.png',
              'Activity',
              0,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserActivity(
                            user: widget.user,
                          )),
                );
              },
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Wallet.png',
              'Payment',
              1,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPayment(
                            user: widget.user,
                          )),
                );
              },
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Hombuddynav.png',
              '',
              2,
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserHomePage(user: widget.user)),
                );
              },
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
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserAccount(user: widget.user),
                  ),
                );
              },
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
}

void _logout(BuildContext context) {
  // Show an alert dialog to confirm logout
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(
            255, 255, 255, 255), // Set background color to white
        title: const Column(
          children: [
            Text(
              "Oh No, You are Leaving",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Are you sure you want to logout?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Image.asset(
          'lib/assets/images/Ohnoo.png', // Path to your logout image
          height: 200, // Adjust height as needed
          width: 200, // Adjust width as needed
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey, // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "     No     ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // Perform logout operation
                  await FirebaseAuth.instance.signOut();

                  // Close the dialog
                  Navigator.of(context).pop();

                  // Navigate back to the FirstLogin page and clear the navigation stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const FirstLogin()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF003B5F), // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "     Yes     ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _savelocation(BuildContext context, UserModel userModel) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SavedLocations(userModel: userModel),
    ),
  );
}

void _BankAccount(BuildContext context, UserModel user) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserPayment(user: user),
    ),
  );
}

void _Setting(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SettingsPage(),
    ),
  );
}

void _HelpCenterr(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HelpCenterPage(),
    ),
  );
}

void _TOC(
  BuildContext context,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TermsAndConditionLog(),
    ),
  );
}

class PointyTopClipper extends CustomClipper<Path> {
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
