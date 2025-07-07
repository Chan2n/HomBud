import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:hombuddy/pages/FlowsBooking/CartModel.dart';
import 'package:hombuddy/pages/FlowsBooking/BookingFlow4.dart';

class ServiceDetailsScreen3 extends StatefulWidget {
  final UserModel user;
  final String bookingId;
  final List<CartItem> cartItems;
  final String? imageUrl; // Optional imageUrl parameter

  const ServiceDetailsScreen3({
    super.key,
    required this.user,
    required this.bookingId,
    required this.cartItems,
    this.imageUrl, // Initialize imageUrl as an optional parameter
  });

  @override
  _ServiceDetailsScreen3State createState() => _ServiceDetailsScreen3State();
}

class _ServiceDetailsScreen3State extends State<ServiceDetailsScreen3> {
  String? photoStatus;
  String? videoStatus;
  late String? imageUrl;
  late TextEditingController _detailsController;
  bool _materialSelectionMade =
      false; // Track whether material selection is made
  String? _selectedMaterialOption; // Track the selected material option
  bool _isLoading = false; // Track loading status

  @override
  void initState() {
    super.initState();
    _detailsController = TextEditingController();
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    setState(() {
      _isLoading = true;
    });

    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Upload image to Firebase Storage and get the URL
        imageUrl = await uploadImageToFirestore(pickedFile.path);
        setState(() {
          photoStatus = "Photo Taken";
        });
        // Update booking with image URL only if imageUrl is not null
        if (imageUrl != null) {
          await updateBookingWithImageUrl(imageUrl!);
        }
      } else {
        // Set imageUrl to null when the user cancels picking a photo
        imageUrl = null;
        // Show notification that no photo was added
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Seems like you did not add a photo'),
            duration: Duration(seconds: 3), // Show for 3 seconds
          ),
        );
      }
    } else {
      print('Camera permission not granted');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> pickVideo() async {
    setState(() {
      _isLoading = true;
    });

    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final pickedFile =
          await ImagePicker().pickVideo(source: ImageSource.camera);
      if (pickedFile != null) {
        // Handle the video as needed
        setState(() {
          videoStatus = "Video Taken";
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> uploadImageToFirestore(String imagePath) async {
    try {
      // Get the image file from the file path
      File imageFile = File(imagePath);

      // Create a reference to the Firebase Storage bucket
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(
              'bookings/${widget.bookingId}/${path.basename(imageFile.path)}');

      // Upload the file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL of the uploaded file
      String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image to Firebase Storage: $error');
      rethrow; // Propagate the error back to the caller if necessary
    }
  }

  // Function to update Firestore document for the booking with the image URL
  Future<void> updateBookingWithImageUrl(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.bookingId)
          .update({'photoUrl': imageUrl});
    } catch (error) {
      print('Error updating booking with image URL: $error');
    }
  }

  Future<void> requestPermissions() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }

    if (await Permission.camera.isGranted &&
        await Permission.storage.isGranted) {
      print("Camera and Storage permissions granted.");
    } else {
      print("Permissions not granted. Access to camera and storage denied.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Service Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Image.asset(
            'lib/assets/images/BookingLogo.png',
            width: 50,
            height: 50,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('lib/assets/images/Detailsbook.png',
                        width: 130, height: 150),
                    const SizedBox(width: 30),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add On Materials',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Lacking some materials? We got you Buddy!"
                            "Our Experts can run to get them for you.",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Convenience Fee: Php 200',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showMaterialConfirmation(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selectedMaterialOption == 'NeedMaterials'
                                    ? const Color(0xFF0067A5)
                                    : null, // Set color based on selection
                          ),
                          child: Text(
                            'Yes, I Need Materials',
                            style: TextStyle(
                              fontSize: 13,
                              color: _selectedMaterialOption == 'NeedMaterials'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showOwnMaterialConfirmation(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selectedMaterialOption == 'OwnMaterials'
                                    ? const Color(0xFF0067A5)
                                    : null, // Set color based on selection
                          ),
                          child: Text(
                            'No, I Have My Own',
                            style: TextStyle(
                              fontSize: 13,
                              color: _selectedMaterialOption == 'OwnMaterials'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0), // Adjust vertical padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Details*',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Feel free to ask an expert for any assistance with the services you'
                        've requested.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 4.0), // Adjust top padding as needed
                        child: Text(
                          'Max COD amount: Php 1,000',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 4.0), // Adjust top padding as needed
                        child: Text(
                          'You can however opt to directly pay GCASH for materials needed',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickImage,
                          style: ElevatedButton.styleFrom(),
                          child: Column(
                            children: [
                              Text(
                                photoStatus != null
                                    ? photoStatus!
                                    : 'Add Photo',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              const Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: pickVideo,
                          style: ElevatedButton.styleFrom(),
                          child: Column(
                            children: [
                              Text(
                                videoStatus != null
                                    ? videoStatus!
                                    : 'Add Video',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              const Icon(
                                Icons.videocam,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _detailsController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText:
                        'Let us know more about your home problem\n \n \n ',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.0, top: 50),
                      child: Text(
                        '1000 Characters',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    hintStyle: TextStyle(fontSize: 11),
                  ),
                  maxLength: 1000,
                  maxLines: null,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (!_materialSelectionMade) {
            // Show an error message if material selection is not made
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Material Selection Required"),
                  content: const Text(
                      "We highly recommend you update us whether you have materials or not."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else if (imageUrl == null) {
            // Automatically trigger photo selection if no photo has been taken
            pickImage();
          } else {
            // Proceed to the next screen if material selection and photo evidence are provided
            String details = _detailsController.text;
            // Save details along with other booking info
            await saveBookingDetails(details);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ServiceDetailsScreen4(
                  user: widget.user,
                  bookingId: widget.bookingId,
                  cartItems: widget.cartItems,
                  imageUrl: imageUrl!, // Pass the image URL to the next screen
                ),
              ),
            );
          }
        },
        label: const Text('Proceed to Booking Summary'),
        icon: const Icon(Icons.arrow_forward),
        backgroundColor: const Color(0xFF0067A5), // Background color
        foregroundColor: Colors.white,
      ),
    );
  }

  Future<void> saveBookingDetails(String details) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.bookingId)
          .update({'details': details});
    } catch (error) {
      print('Error updating booking with details: $error');
    }
  }

  void _showMaterialConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1.0,
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Add on Materials',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0067A5),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text.rich(
                        TextSpan(
                          text: 'There will be a ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Convenience Fee of Php 200',
                              style: TextStyle(
                                color: Color(0xFF0067A5), // Highlight color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' as our experts run to buy the needed materials for you.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'The Payment for the materials bought will be directly paid to the Experts. ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'The Expert will message the receipt after purchasing the needed materials for you ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Set material selection flag to true
                      _materialSelectionMade = true;
                      _selectedMaterialOption = 'NeedMaterials';
                      await FirebaseFirestore.instance
                          .collection('bookings')
                          .doc(widget.bookingId)
                          .update({'materials': 'Pay'});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Additional payment for Materials added'),
                          duration: Duration(seconds: 4), // Show for 4 seconds
                        ),
                      );
                      // Delayed action to navigate after 4 seconds
                      Timer(const Duration(seconds: 0), () {
                        Navigator.of(context).pop();
                      });
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0067A5), // Background color
                    ),
                    child: const Text(
                      '     Yes, I Agree     ',
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showOwnMaterialConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 1.0,
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'No Additional Materials Needed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0067A5),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'In cases where the HomBuddy Expert is unable to'
                        'complete booked services due to homeowner-related '
                        'issues (ex. no faucet provided by user in fixing the tap), '
                        'the service will be cancelled and a 20% penalty will be applied',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Set material selection flag to true
                      _materialSelectionMade = true;
                      _selectedMaterialOption = 'OwnMaterials';
                      // Update the database to indicate that the user has their own materials
                      await FirebaseFirestore.instance
                          .collection('bookings')
                          .doc(widget.bookingId)
                          .update({'materials': 'Own'});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('I have my own materials'),
                          duration: Duration(seconds: 4),
                        ),
                      );
                      // Delayed action to navigate after 4 seconds
                      Timer(const Duration(seconds: 0), () {
                        Navigator.of(context).pop();
                      });
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0067A5), // Background color
                    ),
                    child: const Text(
                      '     I Understand     ',
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
