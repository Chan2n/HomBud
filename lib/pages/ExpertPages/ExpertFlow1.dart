import 'package:flutter/material.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertFlow2.dart';

class ExpertFlow1 extends StatefulWidget {
  const ExpertFlow1({super.key});

  @override
  _ExpertFlow1State createState() => _ExpertFlow1State();
}

class _ExpertFlow1State extends State<ExpertFlow1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => const ExpertFlow2(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003B5F),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'lib/assets/images/SplashExpert.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
