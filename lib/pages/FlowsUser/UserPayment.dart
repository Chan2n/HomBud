import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccount.dart';
import 'package:hombuddy/pages/FlowsUser/UserActivity.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';
import 'package:hombuddy/pages/FlowsUser/UserMessage.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class UserPayment extends StatefulWidget {
  final UserModel user;

  const UserPayment({super.key, required this.user});

  @override
  _UserPaymentState createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment>
    with SingleTickerProviderStateMixin {
  late AnimationController onTapController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    onTapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    onTapController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserActivity(user: widget.user)),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserPayment(user: widget.user)),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserHomePage(user: widget.user)),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserMessagingPage(
                      user: widget.user,
                      expertID: '',
                    )),
          );

          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserAccount(user: widget.user)),
          );
          break;
      }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Currently Linked',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              _buildPaymentMethod(
                image: 'lib/assets/images/PNB.png',
                title: 'PNB',
                number: '',
                onTap: () {
                  _showLinkingNotAvailable(context);
                },
              ),
              const SizedBox(height: 20),
              _buildPaymentMethod(
                image: 'lib/assets/images/Gcash.png',
                title: 'Gcash',
                number: '',
                onTap: () {
                  _showLinkingNotAvailable(context);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Add Other Methods',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              _buildPaymentMethod(
                image: 'lib/assets/images/Paymaya.png',
                title: 'PayMaya',
                onTap: () {
                  _showLinkingNotAvailable(context);
                },
              ),
              const SizedBox(height: 20),
              _buildPaymentMethod(
                image: 'lib/assets/images/bank.png',
                title: 'Credit/Debit Card',
                onTap: () {
                  _showLinkingNotAvailable(context);
                },
              ),
              const SizedBox(height: 20),
              _buildPaymentMethod(
                image: 'lib/assets/images/bank2.png',
                title: 'Bank Account',
                onTap: () {
                  _showLinkingNotAvailable(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Activity.png',
              'Activity',
              0,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserActivity(user: widget.user),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Wallet.png',
              'Payment',
              1,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPayment(user: widget.user),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Hombuddynav.png',
              '',
              2,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHomePage(user: widget.user),
                ),
              ),
              isMain: true,
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Message.png',
              'Message',
              3,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserMessagingPage(
                    user: widget.user,
                    expertID: '',
                  ),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Account.png',
              'Account',
              4,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAccount(user: widget.user),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(BuildContext context, String iconPath,
      String label, int index, VoidCallback onTap,
      {bool isMain = false}) {
    return GestureDetector(
      onTap: () {
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
          onTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70, // Fix width for the container
        child: ClipPath(
          clipper: PointyTopClipper(),
          child: Container(
            color: _selectedIndex == index
                ? const Color(0xFF0067A5)
                : Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(
                    decoration: isMain
                        ? BoxDecoration(
                            color: const Color(0xFF0067A5),
                            borderRadius: BorderRadius.circular(15),
                          )
                        : null,
                    padding: isMain ? const EdgeInsets.all(8) : EdgeInsets.zero,
                    child: Image.asset(
                      iconPath,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                if (label.isNotEmpty)
                  Text(
                    label,
                    style: TextStyle(
                      color: _selectedIndex == index ? Colors.white : null,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required String image,
    required String title,
    String? number,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        onTapController.forward(from: 0);
      },
      onTapDown: (_) => onTapController.reverse(from: 1),
      onTapCancel: () => onTapController.forward(from: 0),
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 10), // Add margin to create space for shadow
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white, // Ensure the background is white
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (number != null) ...[
                const SizedBox(width: 10),
                Text(
                  number,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
              const Spacer(),
              AnimatedBuilder(
                animation: CurvedAnimation(
                  parent: onTapController,
                  curve: Curves.easeInOut,
                ),
                builder: (context, child) {
                  return Transform.scale(
                    scale: onTapController.value == 1 ? 1 : 0.95,
                    child: child,
                  );
                },
                child: const Text(
                  '>',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLinkingNotAvailable(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Linking not Available'),
          content: const Text('Linking is not available yet.'),
          actions: [
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
  }
}
