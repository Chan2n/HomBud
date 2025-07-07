// import 'package:flutter/material.dart';

// import '../BookingPage.dart';

// class AccountPage extends StatefulWidget {
//   const AccountPage({Key? key}) : super(key: key);

//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   int _currentIndex = 4;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 1 / 10,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('lib/assets/images/Hombbu.jpg'),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.black),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipOval(
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   child: Container(
//                     width: 100.0,
//                     height: 100.0,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image:
//                             AssetImage('lib/assets/images/ProfileExamplee.jpg'),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16.0),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Maayong Adlaw',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Username', // Replace with the username or a variable
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       Text(
//                         'Number API to be implemented',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(
//               height: 50,
//             ),

//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
// //DIVIDER CLEAN
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow2(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow3(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow4(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow5(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow6(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow7(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow8(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             _buildServiceRow9(
//               context,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE //OTHER SERVICE
//             //DIVIDER CLEAN
//             Container(
//               color: Color(0xFF00588D), // Set the background color here
//               height: 2, // Set the height
//               width: double.infinity, // Set the width to match the parent
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });

//           switch (_currentIndex) {
//             case 0: // Assuming the Activity icon is the first item
//               if (ModalRoute.of(context)?.settings.name != '/activity') {
//                 Navigator.pushNamed(context, '/activity');
//               }
//               break;
//             case 4:
//               if (ModalRoute.of(context)?.settings.name != '/account') {
//                 Navigator.pushNamed(context, '/account');
//               }
//               break;
//             case 2:
//               if (ModalRoute.of(context)?.settings.name != '/booking') {
//                 Navigator.pushNamed(context, '/booking');
//               }
//               break;
//             default:
//               // Handle other bottom navigation bar items or do nothing
//               break;
//           }
//         },
//         selectedItemColor: Colors.blue, // Adjust the color as needed
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/ActivityIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Activity',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/PaymentIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Payment',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/HBIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'HB',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/MessagesIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/ProfileIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Account',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildServiceRow(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15), // Added padding
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/ManageMyWallet.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Manage My Wallet', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow2(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/ManageLinkedBank.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Manage Linked Bank Accounts', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow3(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/ManageMyRewards.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 23, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Manage My Rewards', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow4(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/SavedLocations.jpg', // Replace with the actual path
//               width: 20, // Adjust the width as needed
//               height: 30, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Saved Locations', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow5(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/BookingHistory.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Booking History', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow6(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/AboutUs.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'About Us', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow7(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/TermsAndConditions.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Terms and Conditions', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow8(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/Logout.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Logout', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceRow9(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => BookingPage(),
//         ));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'lib/assets/images/ChatWith.jpg', // Replace with the actual path
//               width: 25, // Adjust the width as needed
//               height: 25, // Adjust the height as needed
//               fit: BoxFit.fill,
//             ),
//             SizedBox(width: 10), // Add some spacing between image and text
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Chat with HomBuddy', // Updated title
//                   style: TextStyle(fontSize: 22, color: Color(0xFF0067A5)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
