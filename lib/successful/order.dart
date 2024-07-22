import 'package:app_coffee/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessful extends StatefulWidget {
  const OrderSuccessful({super.key});

  @override
  State<OrderSuccessful> createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Mainpage(),
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
            Stack(
              alignment: Alignment.center,
              children: [
                const Image(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/Order.png")),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(right: 100),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(1),
                          minimumSize: const Size(0, 0),
                          backgroundColor: const Color(0xFFC3916B),
                          side: BorderSide.none,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ),
                ),
                Positioned(
                  top: 100,
                  bottom: 0,
                  child: SvgPicture.asset(
                    "assets/vectors/tick.svg",
                    width: 92,
                    height: 92,
                  ),
                ),
                const Positioned(
                  top: 380,
                  bottom: 0,
                  child: Text(
                    "Thành công",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      height: 4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
