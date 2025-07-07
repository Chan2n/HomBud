import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow4.dart';
import 'package:page_transition/page_transition.dart';

class CodeVerifications extends StatefulWidget {
  final String mobileNumber; // Define a parameter to receive the mobile number

  // Constructor with the mobileNumber parameter
  const CodeVerifications({super.key, required this.mobileNumber});

  @override
  State<CodeVerifications> createState() => _CodeVerificationsState();
}

class _CodeVerificationsState extends State<CodeVerifications> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  int totalAccounts = 0; // Variable to keep track of total accounts

  @override
  void initState() {
    super.initState();
    controllers = List.generate(5, (index) => TextEditingController());
    focusNodes = List.generate(5, (index) => FocusNode());
    for (int i = 0; i < controllers.length - 1; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }

    // Get the last ID number from Firestore
    getLastIDNumber();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Method to get the last ID number from Firestore
  void getLastIDNumber() async {
    try {
      // Query the 'User' collection to get the last document
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('User').get();

      // Get the last document
      if (querySnapshot.docs.isNotEmpty) {
        // Get the last document ID and convert it to an integer
        totalAccounts = int.parse(querySnapshot.docs.last.id);
      }
    } catch (e) {
      print('Error getting last ID number: $e');
    }
  }

  // Function to check if the document has the 'pin' field
  Future<bool> doesDocumentHavePin(String documentId) async {
    try {
      // Get the document snapshot
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(documentId)
          .get();

      // Cast snapshot.data() to Map<String, dynamic>? and check if it contains the 'pin' field
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      return data != null && data.containsKey('pin');
    } catch (e) {
      print('Error checking document for pin: $e');
      return false;
    }
  }

  // Function to delete documents without 'pin' field
  Future<void> deleteDocumentsWithoutPin() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('User').get();

      // Iterate through each document
      for (DocumentSnapshot doc in querySnapshot.docs) {
        if (!(await doesDocumentHavePin(doc.id))) {
          // Delete the document if 'pin' field is not found
          await FirebaseFirestore.instance
              .collection('User')
              .doc(doc.id)
              .delete();
        }
      }
    } catch (e) {
      print('Error deleting documents without pin: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/images/MaayongAdlawHom.png',
              width: 150,
            ),
            const SizedBox(height: 20.0),
            const Text(
              '',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0067A5),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Code',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'We’ve sent an SMS with an activation code to your phone',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Hombuddy Mobile Number Verification through (SMS) is not yet available, please do click Temporary Registry for temporary registration.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red, // Set the color to red for emphasis
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counter: Offstage(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Show loading dialog with message
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Processing Account Creation'),
                        ],
                      ),
                    );
                  },
                );

                // Delete documents without 'pin' field
                await deleteDocumentsWithoutPin();

                String code = '';
                for (var controller in controllers) {
                  code += controller.text;
                }

                try {
                  totalAccounts++; // Increment totalAccounts by 1

                  // Set the user's ID number as totalAccounts
                  String userId = totalAccounts.toString();

                  // Add the document to the 'User' collection with ID as userId
                  await FirebaseFirestore.instance
                      .collection('User')
                      .doc(userId)
                      .set({
                    'IDNumber': userId, // Use userId as IDNumber
                    'UserType': 'regular', // Set initial UserType
                    'totalBookings': 0, // Set initial totalBookings
                    'mobileNumber':
                        widget.mobileNumber, // Save the mobile number
                  });

                  // Close loading dialog
                  Navigator.pop(context);

                  // Navigate to UserLocation widget and pass userId
                  navigateToUserLocationPage(userId);
                } catch (e) {
                  print('Error creating account: $e');
                  // Close loading dialog
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(const Color(0xFF003B5F)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                'Temporary Register',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToUserLocationPage(String userId) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 800),
        child: UserLocation(userId),
      ),
    );
  }
}
