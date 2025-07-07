// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:hombuddy/pages/FlowsCreation/Flow3.dart';
// import 'package:hombuddy/pages/FlowsUser/UserFlow1.dart';
// import 'package:page_transition/page_transition.dart';

// class NumberVerify extends StatefulWidget {
//   const NumberVerify({
//     super.key,
//   });

//   @override
//   _NumberVerifyState createState() => _NumberVerifyState();
// }

// class _NumberVerifyState extends State<NumberVerify> {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'lib/assets/images/MaayongAdlawHom.png',
//                 width: 200.0,
//               ),
//               const SizedBox(height: 20.0),
//               const Text(
//                 'Register via Number',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Color(0xFF0067A5),
//                 ),
//               ),
//               const Text(
//                 'Hello future user, this number will be used for your future logins',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Color(0xFF0067A5),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10.0, vertical: 0.0),
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 175, 175, 175),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: TextField(
//                         controller: _phoneNumberController,
//                         keyboardType: TextInputType.phone,
//                         decoration: const InputDecoration(
//                           hintText: 'Input non registered mobile number',
//                           border: InputBorder.none,
//                           counterText: '', // Hides the counter
//                         ),
//                         maxLength: 11,
//                         maxLengthEnforcement: MaxLengthEnforcement.enforced,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20.0),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     String mobileNumber = _phoneNumberController.text;
//                     if (mobileNumber.isNotEmpty &&
//                         RegExp(r'^09[0-9]{9}$').hasMatch(mobileNumber)) {
//                       bool numberExists =
//                           await checkMobileNumberExists(mobileNumber);
//                       if (numberExists) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('This number is already taken.'),
//                           ),
//                         );
//                       } else {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.fade,
//                             duration: const Duration(milliseconds: 800),
//                             child:
//                                 CodeVerifications(mobileNumber: mobileNumber),
//                           ),
//                         );
//                       }
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter a valid phone number.'),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF003B5F),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10.0),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       PageTransition(
//                         type: PageTransitionType.fade,
//                         duration: const Duration(milliseconds: 800),
//                         child: const FirstLogin(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey,
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text(
//                       'Login Existing Account',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> checkMobileNumberExists(String mobileNumber) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('User')
//           .where('mobileNumber', isEqualTo: mobileNumber)
//           .get();
//       return querySnapshot.docs.isNotEmpty;
//     } catch (e) {
//       print('Error checking mobile number existence: $e');
//       return false;
//     }
//   }
// }
