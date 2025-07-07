import 'package:flutter/material.dart';
import 'package:hombuddy/pages/First%20Flow%20Pages/SplashPage3.dart';
import 'package:hombuddy/pages/First%20Flow%20Pages/SplashPage5.dart';

class SplashScreen4 extends StatelessWidget {
  const SplashScreen4({super.key});

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
              'lib/assets/images/Button3top.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button at the top left
          Positioned(
            top: 40, // Adjust the top position as needed
            left: 9, // Adjust the left position as needed
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color(0xFF0067A5), size: 30),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SplashScreen3(),
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
          // Button1 logo at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                // Navigate to the next page with transition animation from right to left
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SplashScreen5(),
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(
                              1.0, 0.0), // Start the transition from the right
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
                height: MediaQuery.of(context).size.height /
                    3.5, // Set one-third of screen height
                color: Colors.transparent,
                child: Image.asset(
                  'lib/assets/images/Button3.png', // Replace with your logo path
                  width: 100, // Adjust logo size as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
