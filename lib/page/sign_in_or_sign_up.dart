import 'package:app_coffee/signIn/signIn.dart';
import 'package:app_coffee/signUp/signUp.dart';
import 'package:flutter/material.dart';

class SignInOrSignUp extends StatelessWidget {
  const SignInOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFC3916B),
          ),
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 150),
              child: Image.asset("assets/images/LogoCoffee.png", width: 412, height: 275,)
            ),
            const Text(
              "Enjoy your favourite coffee",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0.1,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 140,
                padding: const EdgeInsets.only(bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const SignInWidget()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    minimumSize: const Size(400, 10),
                    backgroundColor: const Color(0xFFFFBE98),
                  ),
                  child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.7,
                    color: Color(0xFF000000),
                  ),),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 80,
                padding: const EdgeInsets.only(bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const SignUpWidget()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    minimumSize: const Size(400, 10),
                    backgroundColor: const Color(0xFFECB176),
                  ),
                  child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.7,
                    color: Color(0xFF000000),
                  ),),
                ),
              ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: 267,
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                textAlign: TextAlign.center,
                "By sign in or sign up, you agree to our Terms of Service and Privacy Policy",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.7,
                ),
              ),
              )
            )
          ],)
      ),
    );
  }
}