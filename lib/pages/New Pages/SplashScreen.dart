// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:hombuddy/pages/FlowsCreation/Flow2.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const NumberVerify()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0067A5),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               'lib/assets/img.png', // Adjust image path
//               width: 250,
//               height: 250,
//             ),
//             const SizedBox(height: 50), // Add some space between the texts
//             const Text(
//               'Ma\'ayong adlaw!',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'My App',
//       home: SplashScreen(), // Set SplashScreen as the initial route
//     );
//   }
// }
