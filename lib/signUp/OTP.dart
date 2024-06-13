import 'package:app_coffee/successful/signup.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/svg.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({super.key});

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 24,
        fontFamily: 'Inter',
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      )
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFC3916B),
          ),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: const Icon(Icons.arrow_back, color: Colors.black, size: 30,)
            ),        
            const SizedBox(height: 60,),    
            const Text("OTP Verification",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Colors.black,
             ),
            ),
            const SizedBox(height: 15,),
            Container(
              width: 279.81,
              padding: const EdgeInsets.only(bottom: 5),
              child: const Text("Enter the code from the sms we sent to +84 123 456 789",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 70,),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Colors.white),
                )
              ),
              onCompleted: (pin) => debugPrint(pin),
            ),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 55),
              child: const Text(
                "Timer",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 80,),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const SignupSuccessful()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    minimumSize: const Size(400, 10),
                    backgroundColor: const Color(0xFFFFBE98),
                  ),
                  child: const Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.7,
                    color: Color(0xFF000000),
                ),),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("I didn't receive any code.",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )  
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      color: Colors.red,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}