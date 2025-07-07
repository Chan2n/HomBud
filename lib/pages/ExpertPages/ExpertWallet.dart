import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertDashboard.dart';
import 'package:hombuddy/pages/ExpertPages/Transfer.dart';

class ExpertWallet extends StatefulWidget {
  final String email;

  const ExpertWallet({super.key, required this.email});

  @override
  _ExpertWalletState createState() => _ExpertWalletState();
}

class _ExpertWalletState extends State<ExpertWallet> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> transactions = [
    {'date': '2024-05-01', 'amount': '₱100.00', 'description': 'Service A'},
    {'date': '2024-05-02', 'amount': '₱150.00', 'description': 'Service B'},
    {'date': '2024-05-03', 'amount': '₱200.00', 'description': 'Service C'},
    // Add more example transactions as needed
  ];

  double _creditWalletAmount = 0.00;
  final int _selectedIndex = 1;
  String expertName = '';

  @override
  void initState() {
    super.initState();
    _fetchExpertDetails();
  }

  void _fetchExpertDetails() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Expert')
          .where('Email', isEqualTo: widget.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        setState(() {
          expertName = doc.get('FullName') ?? '';
          _creditWalletAmount = doc.get('Credit Wallet') ?? 0.00;
        });
      }
    } catch (e) {
      // Handle errors
      print(e);
      // Optionally show a snackbar or dialog with an error message
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/expertAccount', arguments: widget.email);
        break;
      case 1:
        // Stay on Wallet Page
        break;
      case 2:
        Navigator.pushNamed(context, '/expertHome', arguments: widget.email);
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(email: widget.email),
          ),
        );
        break;
      case 4:
        Navigator.pushNamed(context, '/expertMessage', arguments: widget.email);
        break;
    }
  }

  void _navigateToTransferAmount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferAmountScreen(
          email: widget.email,
        ),
      ),
    ).then((_) {
      // Refresh the credit wallet amount after returning from the transfer screen
      _fetchExpertDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Wallet',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        // Handle notification icon tap
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  expertName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'From',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 300, // Fixed width to fit 6-digit amounts
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4ECFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Earnings',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '₱0.00', // Example earnings
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'To',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: _navigateToTransferAmount,
                        child: Container(
                          width: 300, // Fixed width to fit 6-digit amounts
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF045D93),
                                Color(0xFF0874B5),
                                Color(0xFF68B3E0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Credit Wallet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '₱${_creditWalletAmount.toStringAsFixed(2)}', // Display fetched amount
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Other Sources',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Additional content goes here
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _onItemTapped(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Account.png',
                      width: 30,
                      height: 30,
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
              onTap: () {
                _onItemTapped(1);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Wallet.png',
                      width: 30,
                      height: 30,
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
              onTap: () {
                _onItemTapped(2);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/MyJobs.png',
                      width: 60,
                      height: 30,
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
              onTap: () {
                _onItemTapped(3);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Dashboard.png',
                      width: 60,
                      height: 30,
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
              onTap: () {
                _onItemTapped(4);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 4 ? const Color(0xFF0067A5) : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/Message.png',
                      width: 30,
                      height: 30,
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
