import 'package:app_coffee/page/sign_in_or_sign_up.dart';
import 'package:app_coffee/page/welcome.dart';
import 'package:app_coffee/screen/splashscreen.dart';
import 'package:app_coffee/signIn/signIn.dart';
import 'package:app_coffee/signUp/signUp.dart';
import 'package:app_coffee/successful/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpWidget(),
    );
  }
}
