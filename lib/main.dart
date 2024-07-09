import 'package:app_coffee/home/home.dart';
import 'package:app_coffee/screen/splashscreen.dart';
import 'package:app_coffee/signIn/signIn.dart';
import 'package:app_coffee/signUp/signUp.dart';
import 'package:app_coffee/screen/slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
