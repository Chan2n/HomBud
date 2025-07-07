import 'package:flutter/material.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow1.dart';
import 'package:hombuddy/pages/FlowsUser/UserFlow1.dart';
import 'package:page_transition/page_transition.dart';

class SignUpHomePage extends StatefulWidget {
  const SignUpHomePage({super.key});

  @override
  State<SignUpHomePage> createState() => _SignUpHomePageState();
}

class _SignUpHomePageState extends State<SignUpHomePage> {
  double logoHeight = 190.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(logoHeight + 270.0),
        child: AppBar(
          backgroundColor: const Color(0xFF0067A5),
          flexibleSpace: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: logoHeight,
                  child: Image.asset(
                    'lib/assets/images/HombuddyBlueFull.jpg',
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Maayong Adlaw!',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircularButton(
                      'lib/assets/images/UserSign.png',
                      const Color(0xFF172434),
                      'Sign up as',
                      'User',
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 300),
                            child: const FirstLogin(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 80.0),
                    _buildCircularButton(
                      'lib/assets/images/ExpertSign.png',
                      const Color(0xFF172434),
                      'Sign up as',
                      'Expert',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExpertFlow1()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        color: const Color(0xFF0067A5),
      ),
    );
  }

  Widget _buildCircularButton(String imagePath, Color overlayColor,
      String text1, String text2, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 110.0,
            height: 110.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: overlayColor,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            text1,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          Text(
            text2,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
