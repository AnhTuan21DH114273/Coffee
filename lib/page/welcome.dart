import 'package:app_coffee/page/sign_in_or_sign_up.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFC3916B),
          ),
          width: double.maxFinite,
          child: Column(
            children:[
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(top: 20, right:10,),
                child: TextButton.icon(
                  icon: const Icon(Icons.language_rounded,color: Colors.white,),
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(9.5, 1, 7.2, 1)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white)
                      )
                    )
                  ),
                label: const Text(
                  "English",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.7,
                    color: Color(0xFFE6E6E6),
                  ),),
                ),
              ),
              Image.asset('assets/images/welcome.png',height:350, width: 430,),
              const Text(
                textAlign: TextAlign.center,
                "Welcome to",
                style: TextStyle(
                  height: 3.1,
                  letterSpacing: 2,
                  color: Colors.black,
                  fontSize: 34,
                  fontFamily: 'Inter',
                ),
              ),
              const Text(
                "BEAR's COFFEE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: -0.5,
                  letterSpacing: 2,
                  color: Color(0xFFAD4B4B),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Inter',
                ),
              ),
              const Text(
                "The best grain, the finest roast, the powerful flavor",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 5,
                  letterSpacing: 1,
                  color: Colors.black,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                padding: const EdgeInsets.only(bottom: 0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_circle_right, color: Colors.black,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const SignInOrSignUp()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    minimumSize: const Size(400, 10),
                    backgroundColor: const Color(0xFFFFBE98),
                  ),
                  label: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    height: 1.7,
                    color: Color(0xFF000000),
                  ),),
                ),
              )
             ]
          ),
        )
      );
  }
}