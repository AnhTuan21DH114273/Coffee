import 'package:app_coffee/signIn/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupSuccessful extends StatefulWidget {
  const SignupSuccessful({super.key});

  @override
  State<SignupSuccessful> createState() => _SignupSuccessfulState();
}

class _SignupSuccessfulState extends State<SignupSuccessful> 
  with SingleTickerProviderStateMixin{
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const SignInWidget(),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 140, left: 20),
              child: SvgPicture.asset("assets/vectors/Leaf_1.svg",),
            ),            
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50),
              child: SvgPicture.asset("assets/vectors/tick.svg",width: 92, height: 92,),
            ),
            const Text("Successful Authentication",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 17,
                height: 4,
                color: Colors.white,
             ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 0, left: 50),
              child: SvgPicture.asset("assets/vectors/Leaf.svg",),
            ),
            Expanded(child: Container(
              alignment: Alignment.bottomCenter,
              
              child: Image.asset("assets/images/SignUpSuccessful.png")
            ),)
          ],
        ),
      ),
    );
  }
}