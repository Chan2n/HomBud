import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertDashboard.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertHomePageNew.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertWallet.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertLoginFlow1.dart';

class ExpertAccount extends StatefulWidget {
  final String email;

  const ExpertAccount({super.key, required this.email});

  @override
  _ExpertAccountState createState() => _ExpertAccountState();
}

class _ExpertAccountState extends State<ExpertAccount> {
  int _selectedIndex = 0;

  Future<Map<String, dynamic>?> _fetchExpertDetails() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Expert')
          .where('Email', isEqualTo: widget.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        return doc.data();
      }
    } catch (e) {
      // Handle errors
      print(e);
    }
    return null;
  }

  void _logout() {
    // Perform any necessary logout operations here
    // Navigate to ExpertLoginFlow1 and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ExpertLoginFlow1()),
      (Route<dynamic> route) => false,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpertWallet(email: widget.email),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpertHomePage(email: widget.email),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(email: widget.email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchExpertDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching expert details'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No expert data found'));
          }

          var expertData = snapshot.data!;
          var fullName = expertData['FullName'] ?? 'Expert FullName';

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30, left: 70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage('lib/assets/images/Profile.png'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0067A5),
                                ),
                              ),
                              Text(
                                widget.email,
                                style: const TextStyle(fontSize: 14),
                              ),
                              GestureDetector(
                                child: const Text(
                                  "Update Profile",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF0067A5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con1.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Manage Linked Bank Accounts',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con2.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'My Rewards',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con4.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con5.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Chat with Hombuddy',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con6.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Help Center',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con7.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'About Hombuddy',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _logout,
                    child: Container(
                      width: 360,
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20), // Set Margin Here
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'lib/assets/images/con8.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                color: Color(0xFF0067A5),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // Set the background color to pure white
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Account.png', // Path to your image asset
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                    Text(
                      'Account',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Wallet.png', // Path to your image asset
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                    Text(
                      'Wallet',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/MyJobs.png', // Path to your image asset
                      width: 60, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                    Text(
                      'My Jobs',
                      style: TextStyle(
                        color: _selectedIndex == 2 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Dashboard.png', // Path to your image asset
                      width: 60, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: _selectedIndex == 3 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _selectedIndex == 4 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Message.png', // Path to your image asset
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                    Text(
                      'Message',
                      style: TextStyle(
                        color: _selectedIndex == 4 ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
