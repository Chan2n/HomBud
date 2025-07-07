import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow1.dart';
import 'package:hombuddy/pages/First%20Flow%20Pages/SplashPage4.dart';

class SplashScreen5 extends StatelessWidget {
  const SplashScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Images filling the top portion
          Positioned.fill(
            top: 0,
            child: Image.asset(
              'lib/assets/images/Button4top.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button at the top left
          Positioned(
            top: 40, // Adjust the top position as needed
            left: 16, // Adjust the left position as needed
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color(0xFF0067A5), size: 30),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SplashScreen4(),
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(
                              -1.0, 0.0), // Start the transition from the left
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SignUpHomePage(),
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.transparent,
                child: Image.asset(
                  'lib/assets/images/Button4.png',
                  width: 350,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
