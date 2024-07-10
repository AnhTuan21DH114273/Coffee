import 'package:app_coffee/category/categorywidget.dart';
import 'package:app_coffee/data/provider/favorite_provider.dart';
import 'package:app_coffee/home/details.dart';
import 'package:app_coffee/home/home.dart';
import 'package:app_coffee/mainpage.dart';
import 'package:app_coffee/page/sign_in_or_sign_up.dart';
import 'package:app_coffee/page/welcome.dart';
import 'package:app_coffee/screen/language.dart';
import 'package:app_coffee/screen/splashscreen.dart';
import 'package:app_coffee/signIn/signIn.dart';
import 'package:app_coffee/signUp/signUp.dart';
import 'package:app_coffee/screen/slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider())
      ],
      child: const MaterialApp(
      home: Mainpage(),
      ),
    );
  }
}
