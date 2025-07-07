import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow3.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertLoginFlow1.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertModel.dart';
import 'package:page_transition/page_transition.dart';

class ExpertFlow2 extends StatefulWidget {
  const ExpertFlow2({super.key});

  @override
  State<ExpertFlow2> createState() => _ExpertFlow2State();
}

class _ExpertFlow2State extends State<ExpertFlow2> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int totalAccounts = 0;

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
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void getLastIDNumber() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Expert').get();
      if (querySnapshot.docs.isNotEmpty) {
        totalAccounts = int.parse(querySnapshot.docs.last.id);
      }
    } catch (e) {
      print('Error getting last ID number: $e');
    }
  }

  Future<bool> doesDocumentHavePin(String documentId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Expert')
          .doc(documentId)
          .get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      return data != null && data.containsKey('pin');
    } catch (e) {
      print('Error checking document for pin: $e');
      return false;
    }
  }

  Future<void> deleteDocumentsWithoutPin() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Expert').get();
      for (DocumentSnapshot doc in querySnapshot.docs) {
        if (!(await doesDocumentHavePin(doc.id))) {
          await FirebaseFirestore.instance
              .collection('Expert')
              .doc(doc.id)
              .delete();
        }
      }
    } catch (e) {
      print('Error deleting documents without pin: $e');
    }
  }

  bool isValidEmail(String email) {
    // Add your email validation logic here
    return email.contains('@gmail.com') || email.contains('@yahoo.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow resizing when the keyboard is open
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0), // Add horizontal padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20.0), // Add top padding
              Image.asset(
                'lib/assets/images/MaayongAdlawHom.png',
                width: 300,
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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Apply to be an Expert!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'What do we want to call you?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (!isValidEmail(emailController.text)) {
                    // If email is invalid, show error message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Invalid Email'),
                          content:
                              const Text('Please enter a valid email address.'),
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
                    return;
                  }

                  // Check if email already exists in the database
                  bool emailExists =
                      await checkEmailExists(emailController.text);
                  if (emailExists) {
                    // If email already exists, show error message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Existing Email'),
                          content:
                              const Text('The entered email already exists.'),
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
                    return;
                  }

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

                  await deleteDocumentsWithoutPin();

                  String code = '';
                  for (var controller in controllers) {
                    code += controller.text;
                  }

                  try {
                    totalAccounts++;

                    String expertId = totalAccounts.toString();

                    ExpertModel expert = ExpertModel(
                      expertidNumber: expertId,
                      email: emailController.text.trim(),
                      FullName: fullNameController.text.trim(),
                      experience:
                          'experienceController.text.trim()', // Add if available
                      pin: 'pinController.text.trim()', // Add if available
                      service: 'serviceController.text.trim()',
                      specializations: [], // Add if available
                      // Add if available
                    );

                    await FirebaseFirestore.instance
                        .collection('Expert')
                        .doc(expertId)
                        .set({
                      'ExpertID': expert.expertidNumber, // Changed to ExpertID
                      'Email': expert.email,
                      'FullName': expert.FullName,
                    });

                    Navigator.pop(context);

                    navigateToExpertFlow3(
                        expertId, fullNameController.text.trim());
                    // Navigate to ExpertFlow3 after account creation
                  } catch (e) {
                    print('Error creating account: $e');
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF003B5F), // Set background color
                ),
                child: const Text(
                  'Apply as an HB Expert',
                  style: TextStyle(color: Colors.white), // Set text color
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to ExpertLoginFlow1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpertLoginFlow1()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF003B5F), // Set background color
                ),
                child: const Text(
                  'Login Existing Expert Account',
                  style: TextStyle(color: Colors.white), // Set text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToExpertFlow3(String expertId, String fullName) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 800),
        child: ExpertFlow3(
            expertId: expertId,
            fullName: fullName), // Pass expertId and fullName
      ),
    );
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Expert')
          .where('Email', isEqualTo: email)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }
}
