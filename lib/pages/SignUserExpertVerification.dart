// import 'package:flutter/material.dart';

// import 'LoginPage.dart';


// class Verification extends StatefulWidget {
//   const Verification({Key? key}) : super(key: key);

//   @override
//   State<Verification> createState() => _VerificationState();
// }

// class _VerificationState extends State<Verification> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 60.0,
//               backgroundImage: AssetImage('lib/assets/images/profile_photo.jpg'),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Hello, [Expert\'s Name]! Thank you for joining us! You are almost finished completing your profile!',
//               style: TextStyle(fontSize: 18.0),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.0),
//             _buildInfoTile('About Me'),
//             _buildInfoTile('ID Verification'),
//             SizedBox(height: 32.0), // Add extra space
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                    MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF0067A5), // Set the background color to #0067A5
//                 minimumSize: Size(double.infinity, 50), // Make it wider
//               ),
//               child: Text(
//                 'Submit For Approval',
//                 style: TextStyle(
//                   color: Colors.white, // Set the text color to white
//                   fontSize: 18.0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoTile(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Handle the action when the + button is pressed
//             },
//             child: Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }
