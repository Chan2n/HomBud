import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class UserAccountChange extends StatefulWidget {
  final UserModel user;

  const UserAccountChange({super.key, required this.user});

  @override
  _UserAccountChangeState createState() => _UserAccountChangeState();
}

class _UserAccountChangeState extends State<UserAccountChange> {
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    _nameController = TextEditingController(text: widget.user.fullName);
    _mobileController = TextEditingController(text: widget.user.mobileNumber);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final String newMobileNumber = _mobileController.text;

    if (!RegExp(r'^09\d{9}$').hasMatch(newMobileNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Mobile number must start with 09 and be 11 digits long.')),
      );
      return;
    }

    if (newMobileNumber != widget.user.mobileNumber) {
      _showMobileNumberChangeDialog(newMobileNumber);
    } else {
      await _updateUserProfile();
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      await widget.user.updateProfile(
        fullName: _nameController.text,
        mobileNumber: _mobileController.text,
        email: _emailController.text,
      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.of(context).pop();
    } catch (error) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $error')),
      );
    }
  }

  void _showMobileNumberChangeDialog(String newMobileNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 242, 247, 250),
          title: const Text('Mobile Number Change',
              style: TextStyle(color: Colors.black)),
          content: const Text(
            'You\'ve changed your Mobile Number, so you are aware you will login with your new saved Mobile Number.',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No, I will Cancel',
                  style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _updateUserProfile();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF003B5F), // Set button color to blue
              ),
              child: const Text('Yes, I understand',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'lib/assets/images/BookingLogo.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered image
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('lib/assets/images/Profile.png'),
                  ),
                ),
              ),
              // Full Name field
              const Text(
                'Full Name',
                style: TextStyle(
                  color: Color(0xFF0067A5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.user.fullName,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Mobile Number field
              const SizedBox(height: 10),
              const Text(
                'Mobile Number',
                style: TextStyle(
                  color: Color(0xFF0067A5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '', // Remove the character counter
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                      ),
                    ),
                  ),
                ],
              ),
              // Email Address field
              const SizedBox(height: 15),
              const Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xFF0067A5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.user.email,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF003B5F), // Set button color to #003B5F
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
