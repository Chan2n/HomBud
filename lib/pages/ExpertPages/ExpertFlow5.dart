import 'package:flutter/material.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow6.dart';

class ExpertFlow5 extends StatefulWidget {
  final String expertId;
  final String fullName;

  const ExpertFlow5({super.key, required this.expertId, required this.fullName});

  @override
  _ExpertFlow5State createState() => _ExpertFlow5State();
}

class _ExpertFlow5State extends State<ExpertFlow5> {
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _meaningfulExperienceController = TextEditingController();

  @override
  void dispose() {
    _experienceController.dispose();
    _meaningfulExperienceController.dispose();
    super.dispose();
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Incomplete Information"),
          content: const Text("Please fill out all fields before continuing."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onContinuePressed() {
    if (_experienceController.text.isEmpty || _meaningfulExperienceController.text.isEmpty) {
      _showWarningDialog(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpertFlow6(
            expertId: widget.expertId,
            fullName: widget.fullName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Ma'ayong Adlaw",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Thank you for joining us! Let us get to know you by filling up the information below",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "My Past Work Experiences",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "1. How long have you been working in this Industry?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your past work experience',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "2. Share your most meaningful experience working in this industry",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: _meaningfulExperienceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your meaningful experience',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _onContinuePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003B5F),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 50.0),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Image.asset(
              'lib/assets/images/homblue.png', // Resplace 'assets/logo.png' with your logo path
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }
}
