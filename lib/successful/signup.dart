import 'package:app_coffee/signIn/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupSuccessful extends StatefulWidget {
  const SignupSuccessful({super.key});

  @override
  State<SignupSuccessful> createState() => _SignupSuccessfulState();
}

class _SignupSuccessfulState extends State<SignupSuccessful> {
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
            const SizedBox(height: 185,),
            Stack(
              alignment: Alignment.center,
              children: [
              const Positioned(
                child: SizedBox(
                  height: 297.63,
                  width: 430,
                )
              ),
              Positioned(
                top: 100,
                bottom: 0,
                child: SvgPicture.asset("assets/vectors/tick.svg",width: 92, height: 92,),
              ),
              Positioned(
                top: 220,
                left: 40,
                bottom: 0,
                child: SvgPicture.asset("assets/vectors/Leaf.svg",width: 59.26, height: 60.63,),
              ),
              Positioned(
                top: 0,
                left: 10,
                bottom: 200,
                child: SvgPicture.asset("assets/vectors/Leaf_1.svg",width: 66.39, height: 68.74,),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: SvgPicture.asset("assets/vectors/Leaf_2.svg",width: 137.02, height: 233.45,),
              ),
              const Positioned(
                top: 250,
                bottom: 0,
                child: Align(alignment: Alignment.center,
                  child: Text("Xác thực thành công",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    height: 3,
                    color: Colors.white,
                    ),
                  ),
                ),
                ),
              ],
            ),
            const Image(
              image: 
              AssetImage("assets/images/SignUpSuccessful.png"
              )
            )
          ],
        ),
      ),
    );
  }
}