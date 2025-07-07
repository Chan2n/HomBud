import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertLoginFlow2.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow1.dart';

class ExpertLoginFlow1 extends StatefulWidget {
  const ExpertLoginFlow1({super.key});

  @override
  _ExpertLoginFlow1State createState() => _ExpertLoginFlow1State();
}

class _ExpertLoginFlow1State extends State<ExpertLoginFlow1> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to pure white
      appBar: AppBar(
        backgroundColor:
            Colors.white, // Set the AppBar background color to white
        elevation: 0, // Remove AppBar shadow
        title: const Text(
          'Login Existing Expert Account',
          style: TextStyle(color: Colors.black), // Set the text color to black
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Set the icon color to black
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpHomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/MaayongAdlawHom.png',
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 20),
              const Text(
                'Use your email to login as an expert',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Enter Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text.trim();
                  loginWithEmail(email);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003B5F),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginWithEmail(String email) async {
    try {
      // Check if the provided email exists in the Expert collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Expert')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Email exists, retrieve the pin and navigate to ExpertLoginFlow2
        String pin = querySnapshot.docs.first.get('pin');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertLoginFlow2(
              email: email,
              pin: pin,
              pinControllers: List.generate(6, (_) => TextEditingController()),
            ),
          ),
        );
      } else {
        // Email doesn't exist, display error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Email'),
              content: const Text('The entered email does not exist.'),
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
      }
    } catch (e) {
      print('Error logging in with email: $e');
    }
  }
}
