import 'package:flutter/material.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow7.dart';

class ExpertFlow6 extends StatefulWidget {
  final String expertId;
  final String fullName;

  const ExpertFlow6(
      {super.key, required this.expertId, required this.fullName});

  @override
  _ExpertFlow6State createState() => _ExpertFlow6State();
}

class _ExpertFlow6State extends State<ExpertFlow6> {
  final TextEditingController _frontIdController = TextEditingController();
  final TextEditingController _backIdController = TextEditingController();

  @override
  void dispose() {
    _frontIdController.dispose();
    _backIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Show the dialog when the page is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("ID Verification"),
            content: const Text(
                "We will implement this later for an admin to see and approve your valid ID"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    });
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
                  const SizedBox(height: 20),
                  const Text(
                    "ID Verification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28, // Adjust the font size as needed
                    ),
                  ),
                  const Text(
                    "We just need more information from you through uploading a valid ID",
                    style: TextStyle(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Upload Front ID Photo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Implement upload photo functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 247, 251, 253),
                          ),
                          child: const Text(
                            'Upload Photo',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Upload Back ID Photo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Implement upload photo functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 247, 251, 253),
                          ),
                          child: const Text(
                            'Upload Photo',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpertFlow7(
                              expertId: widget.expertId,
                              fullName: widget.fullName,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003B5F),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
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
              'lib/assets/images/homblue.png', // Replace 'assets/logo.png' with your logo path
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }
}
