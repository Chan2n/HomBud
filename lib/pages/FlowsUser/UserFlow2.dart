import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class LoginPin extends StatefulWidget {
  final String mobileNumber;

  const LoginPin(this.mobileNumber, {super.key});

  @override
  _LoginPinState createState() => _LoginPinState();
}

class _LoginPinState extends State<LoginPin> {
  String pin = '';
  final pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void signInWithPhoneNumber(BuildContext context) async {
    try {
      String enteredPin = pin;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .where('mobileNumber', isEqualTo: widget.mobileNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String storedPin = querySnapshot.docs.first.get('pin');

        if (storedPin == enteredPin) {
          final user = UserModel(
            idNumber: querySnapshot.docs.first.get('IDNumber'),
            location: querySnapshot.docs.first.get('Location.name'),
            userType: querySnapshot.docs.first.get('UserType'),
            email: querySnapshot.docs.first.get('email'),
            fullName: querySnapshot.docs.first.get('fullName'),
            totalBookings: querySnapshot.docs.first.get('totalBookings'),
            mobileNumber: widget.mobileNumber,
            pin: enteredPin,
            profilePictureUrl: UserModel.defaultProfilePictureUrl,
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => UserHomePage(user: user),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect pin. Please try again.'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print('Error signing in with phone number: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/LoginPin.png',
                  width: 150,
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Finally, Your final step....',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Enter 6 numbers to keep your account safe',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        6, (index) => PinCircle(filled: index < pin.length)),
                  ),
                ),
                const SizedBox(height: 20.0),
                Offstage(
                  offstage: true,
                  child: TextField(
                    focusNode: focusNode,
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onChanged: (value) {
                      setState(() {
                        pin = value;
                      });
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 24),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (pin.length == 6) {
                        signInWithPhoneNumber(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a 6-digit PIN.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003B5F),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
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

class PinCircle extends StatelessWidget {
  final bool filled;

  const PinCircle({super.key, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? Colors.black : Colors.transparent,
          border: Border.all(color: filled ? Colors.transparent : Colors.black),
        ),
      ),
    );
  }
}
