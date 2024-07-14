import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:app_coffee/data/provider/favorite_provider.dart';
import 'package:app_coffee/data/provider/order_provider.dart';
import 'package:app_coffee/mainpage.dart';
import 'package:app_coffee/screen/language.dart';
import 'package:app_coffee/screen/splashscreen.dart';
import 'package:app_coffee/signIn/confirmPass.dart';
import 'package:app_coffee/signUp/signUp.dart';
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
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CartCounter()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MaterialApp(
      home: Mainpage(),
      ),
    );
  }
}
