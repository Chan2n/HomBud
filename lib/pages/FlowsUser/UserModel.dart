import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String idNumber;
  late final String location;
  final String userType;
  String email;
  String fullName;
  final int totalBookings;
  String mobileNumber;
  final String pin;
  String profilePictureUrl;

  static const String defaultProfilePictureUrl =
      'lib/assets/images/Profile.png';

  UserModel({
    required this.idNumber,
    required this.location,
    required this.userType,
    required this.email,
    required this.fullName,
    required this.totalBookings,
    required this.mobileNumber,
    required this.pin,
    required this.profilePictureUrl,
  });

  // Add the name getter
  String get name => fullName;

  void updateProfilePictureUrl(String newUrl) {
    profilePictureUrl = newUrl;
  }

  UserModel.fromUser(User user)
      : idNumber = user.uid,
        location = '',
        userType = '',
        email = user.email ?? '',
        fullName = user.displayName ?? '',
        totalBookings = 0,
        mobileNumber = '',
        pin = '',
        profilePictureUrl = user.photoURL ?? UserModel.defaultProfilePictureUrl;

  Future<void> updateProfile({
    String? fullName,
    String? mobileNumber,
    String? email,
  }) async {
    if (fullName != null) {
      this.fullName = fullName;
    }
    if (mobileNumber != null) {
      this.mobileNumber = mobileNumber;
    }
    if (email != null) {
      this.email = email;
    }

    // Update profile information in Firebase Auth
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? firebaseUser = auth.currentUser;
    if (firebaseUser != null) {
      await firebaseUser.updateDisplayName(fullName);
      await firebaseUser.updateEmail(email!);
    }

    // Update profile information in Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference userDoc = firestore.collection('User').doc(idNumber);
    await userDoc.update({
      'fullName': this.fullName,
      'mobileNumber': this.mobileNumber,
      'email': this.email,
    });
  }
}
