import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';

import 'UserModel.dart';

class FinalRatings extends StatefulWidget {
  final String expertId;
  final String bookingId;
  final UserModel user;

  const FinalRatings(
      {super.key,
      required this.expertId,
      required this.bookingId,
      required this.user});

  @override
  _FinalRatingsState createState() => _FinalRatingsState();
}

class _FinalRatingsState extends State<FinalRatings> {
  int _selectedRating = 0;
  final List<bool> _selectedButtons = List.filled(6, false);
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Rate our Expert'),
            Image.asset(
              'lib/assets/images/BookingLogo.png', // Add your logo image path here
              width: 50,
              height: 50,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildStarRating(),
              const SizedBox(height: 20),
              const Text(
                'EXPERIENCED',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildRatingButtons(),
              const SizedBox(height: 20),
              const Text(
                'Share your thoughts with us',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003B5F),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  minimumSize:
                      const Size(double.infinity, 48), // Widen the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          iconSize: 40.0, // Set the size of the star icons here
          icon: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildRatingButtons() {
    List<String> buttonTexts = [
      'Technically Savvy',
      'Highly Responsive',
      'Highly\nEfficient',
      'Reliable\n',
      'Prompt\n',
      'Seasoned Professional'
    ];

    List<String> imagePaths = [
      'lib/assets/images/Savvy.png',
      'lib/assets/images/Responsive.png',
      'lib/assets/images/Efficient.png',
      'lib/assets/images/Reliable.png',
      'lib/assets/images/Prompt.png',
      'lib/assets/images/Professional.png'
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedButtons[index] = !_selectedButtons[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtons[index]
                            ? Colors.blue
                            : const Color(0xFFD4ECFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 60, // Adjust height as needed
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.asset(
                              imagePaths[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      buttonTexts[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedButtons[index + 3] =
                              !_selectedButtons[index + 3];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedButtons[index + 3]
                            ? Colors.blue
                            : const Color(0xFFD4ECFA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SizedBox(
                          height: 60, // Adjust height as needed
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.asset(
                              imagePaths[index + 3],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      buttonTexts[index + 3],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _feedbackController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Enter your feedback here',
      ),
      maxLines: 5,
    );
  }

  void _submitRating() async {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the expert document
    DocumentReference expertRef =
        firestore.collection('Expert').doc(widget.expertId);

    // Run a transaction to update the expert's ratings
    firestore.runTransaction((transaction) async {
      DocumentSnapshot expertSnapshot = await transaction.get(expertRef);

      if (!expertSnapshot.exists) {
        throw Exception("Expert does not exist!");
      }

      double currentAveRating = expertSnapshot['aveRatings'].toDouble();
      int currentTotalRatings = expertSnapshot['totalRatings'].toInt();

      // Calculate the new average rating
      double newTotalRatings = currentTotalRatings + 1;
      double newAveRating =
          (currentAveRating * currentTotalRatings + _selectedRating) /
              newTotalRatings;

      // Update the expert document
      transaction.update(expertRef, {
        'aveRatings': newAveRating,
        'totalRatings': newTotalRatings,
      });
    }).then((_) {
      print('Rating submitted successfully!');
      // Navigate back to UserHomePage and remove previous routes
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => UserHomePage(user: widget.user),
        ),
        (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print('Failed to submit rating: $error');
      // Optionally show an error message
    });

    print('Rating: $_selectedRating');
    print('Selected tags: $_selectedButtons');
    print('Feedback: ${_feedbackController.text}');
  }
}
