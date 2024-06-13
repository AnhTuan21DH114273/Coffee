import 'package:app_coffee/page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Welcome(),
      ));
    });
    super.initState();
  }
  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values
    );
    super.dispose();
  }
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