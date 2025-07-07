// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'ExpertPages/ExpertHomePage.dart';
// import 'FlowsCreation/Flow1.dart';
// import 'BookingPage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> signInWithEmailAndPassword() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       // Get the current user
//       final User? user = _auth.currentUser;

//       if (user != null) {
//         // Assuming your Firestore collection for experts is named 'experts'
//         final expertsCollection =
//             FirebaseFirestore.instance.collection('experts');
//         // Assuming your Firestore collection for users is named 'users'
//         final usersCollection = FirebaseFirestore.instance.collection('users');

//         // Check the 'experts' collection first
//         final expertDoc = await expertsCollection.doc(user.uid).get();
//         final expertData = expertDoc.data() as Map<String, dynamic>?;

//         if (expertData != null && expertData['Type'] == 'Expert') {
//           // User is an expert, navigate to ExpertHomePage
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ExpertHomePage()),
//           );
//         } else {
//           // If not an expert, check the 'users' collection
//           final userDoc = await usersCollection.doc(user.uid).get();
//           final userData = userDoc.data() as Map<String, dynamic>?;

//           if (userData != null && userData['Type'] == 'User') {
//             // User is a user, navigate to UserSign
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BookingPage()),
//             );
//           } else {
//             // Handle other cases as needed
//             print('User is not an expert or user');
//           }
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       // Handle sign-in errors (e.g., wrong email or password)
//       // You can display an error message to the user
//       print('Sign-in error: ${e.message}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFD4ECFA),
//         body: SingleChildScrollView(
//           // Wrap the Column with a SingleChildScrollView
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20.0),
//                   Text(
//                     'Email',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   SizedBox(height: 8.0),
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       hintText: 'Enter your email',
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   Text(
//                     'Password',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   SizedBox(height: 8.0),
//                   TextField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       hintText: 'Enter your password',
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     obscureText: true, // This will hide the entered text
//                   ),

//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Call the sign-in function with email and password
//                       signInWithEmailAndPassword();
//                     },
//                     child: Text('Proceed'),
//                   ),
//                   SizedBox(height: 10.0),
//                   Divider(color: Colors.black),
//                   SizedBox(height: 10.0),
//                   Text('or sign in with'),
//                   SizedBox(height: 10.0),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           // Sign in with Google
//                         },
//                         child: Text('Sign in with Google'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 3.0),
//                       TextButton(
//                         onPressed: () {
//                           // Sign in with Facebook
//                         },
//                         child: Text('Sign in with Facebook'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30.0),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SignUpHomePage()),
//                       );
//                     },
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             'Not registered yet? \nSign up with us today!',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.blue,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Forgot password',
//                             textAlign: TextAlign.right,
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.0), // Add some space before the logo
//                   // Your logo image goes here
//                   Image.asset(
//                     'lib/assets/images/HombuddyLogin.jpg', // Adjust the path to your logo image
//                     width: 160.0, // Adjust the width of the logo
//                     height: 70.0, // Adjust the height of the logo
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
