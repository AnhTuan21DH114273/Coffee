import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC3916B), 
        ),
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Center(
          child: Image.asset('assets/images/LogoCoffee.png'),
          ),
        )
      );
  }
}