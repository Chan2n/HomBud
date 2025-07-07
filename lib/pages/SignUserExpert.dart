// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'SignUserExpertVerification.dart';


// class UserSignExpert extends StatefulWidget {
//   const UserSignExpert({Key? key}) : super(key: key);

//   @override
//   State<UserSignExpert> createState() => _UserSignExpertState();
// }

// class _UserSignExpertState extends State<UserSignExpert> {
//   String selectedProfession = 'Clean Category'; // Default profession
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController dateOfBirthController = TextEditingController();

//   Future<void> _selectDate(BuildContext context) async {
//   DateTime currentDate = DateTime.now();
//   DateTime? selectedDate = await showDatePicker(
//     context: context,
//     initialDate: currentDate,
//     firstDate: DateTime(1900),
//     lastDate: currentDate,
//   );

//   if (selectedDate != null && selectedDate != currentDate) {
//     setState(() {
//       dateOfBirthController.text = "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
//     });
//   }
// }

//   bool passwordObscured = true; // Initially obscure the password

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFD4ECFA),
//       appBar: AppBar(
//         title: Text('Register as Expert'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Full Name',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//                 SizedBox(height: 8.0),
//                 TextField(
//                   controller: fullNameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter your full name',
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//                   'Email',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//                 SizedBox(height: 8.0),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter your email',
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//   'Password',
//   style: TextStyle(fontSize: 18.0),
// ),
// SizedBox(height: 8.0),
// TextField(
//   controller: passwordController,
//   obscureText: passwordObscured, // Set this property based on passwordObscured
//   decoration: InputDecoration(
//     border: OutlineInputBorder(),
//     hintText: 'Enter your password',
//     suffixIcon: IconButton(
//       onPressed: () {
//         setState(() {
//           passwordObscured = !passwordObscured; // Toggle the boolean variable
//         });
//       },
//       icon: Icon(
//         passwordObscured ? Icons.visibility : Icons.visibility_off,
//       ),
//     ),
//   ),
// ),
//                 SizedBox(height: 16.0),
//                 Text(
//   'Date of Birth (mm/dd/yyyy)',
//   style: TextStyle(fontSize: 18.0),
// ),
// SizedBox(height: 8.0),
// GestureDetector(
//   onTap: () {
//     _selectDate(context);
//   },
//   child: AbsorbPointer(
//     child: TextField(
//       controller: dateOfBirthController,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         hintText: 'Select your date of birth',
//       ),
//     ),
//   ),
// ),

//                 SizedBox(height: 16.0),
//                 Text(
//                   'Profession',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//                 SizedBox(height: 8.0),
//                 DropdownButton<String>(
//   value: selectedProfession,
//   onChanged: (String? newValue) {
//     setState(() {
//       selectedProfession = newValue!;
//     });
//   },
//   items: <String>['Clean Category', 'Repair Category', 'Painter Category', 'Women Wellness Category','Home Care Category', 'Men Wellness Category']
//       .map((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value),
//     );
//   }).toList(),
// ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     // Get the user input
//                     String fullName = fullNameController.text;
//                     String email = emailController.text;
//                     String password = passwordController.text;
//                     String dateOfBirth = dateOfBirthController.text;

//                     // Register the user using Firebase Authentication
//                     try {
//                       UserCredential userCredential =
//                           await _auth.createUserWithEmailAndPassword(
//                         email: email,
//                         password: password,
//                       );

//                       if (userCredential.user != null) {
//                         // Create an "expert" document in Firestore with the user data
//                         await _firestore
//                             .collection('experts')
//                             .doc(userCredential.user!.uid)
//                             .set({
//                           'fullName': fullName,
//                           'email': email,
//                           'Type': 'Expert',
//                           'DateOfBirth': dateOfBirth,
//                           'Profession': selectedProfession,
//                           // Add other expert data fields as needed
//                         });

//                         // Navigate to the verification page or any other desired destination
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Verification()),
//                         );
//                       }
//                     } catch (e) {
//                       // Handle registration errors
//                       print('Registration error: $e');
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF0067A5),
//                     minimumSize: Size(double.infinity, 50),
//                     textStyle: TextStyle(color: Colors.white),
//                   ),
//                   child: Text('Submit', style: TextStyle(color: Colors.white)),
//                 ),

//                 SizedBox(height: 30.0),

//                 // Your logo here at the bottom
//                 Image.asset('lib/assets/images/HombuddyLogin.jpg', width: 250.0),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
    
//   }
// }
