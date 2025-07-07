import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow1.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow3.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow2.dart';

class FirstLogin extends StatefulWidget {
  const FirstLogin({
    super.key,
  });

  @override
  State<FirstLogin> createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0067A5)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpHomePage(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/images/MaayongAdlawHom.png',
                width: 200.0,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Login to start booking!',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF0067A5),
                ),
              ),
              const Text(
                'Please enter your phone number',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF0067A5),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 175, 175, 175),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Input Registered Mobile Number',
                          border: InputBorder.none,
                          counterText: '', // Hides the counter
                        ),
                        maxLength: 11,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String mobileNumber = _phoneNumberController.text;
                    if (mobileNumber.isNotEmpty &&
                        RegExp(r'^09[0-9]{9}$').hasMatch(mobileNumber)) {
                      _showLoadingDialog(); // Show loading dialog
                      loginWithPhoneNumber(mobileNumber);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid phone number.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003B5F),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
            ],
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Fetching Data"),
            ],
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.pop(context);
  }

  Future<void> loginWithPhoneNumber(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .where('mobileNumber', isEqualTo: phoneNumber)
          .get();

      _hideLoadingDialog(); // Hide loading dialog

      if (querySnapshot.docs.isNotEmpty) {
        // Navigate to the login pin page if the user exists
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPin(phoneNumber),
          ),
        );
      } else {
        // Navigate to the registration page if the user does not exist
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeVerifications(mobileNumber: phoneNumber),
          ),
        );
      }
    } catch (e) {
      _hideLoadingDialog(); // Hide loading dialog in case of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging in with phone number: $e'),
        ),
      );
      print('Error logging in with phone number: $e');
    }
  }
}
