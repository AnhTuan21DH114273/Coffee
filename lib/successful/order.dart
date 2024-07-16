import 'package:app_coffee/order/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessful extends StatelessWidget {
  const OrderSuccessful({super.key});

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
                    "Successful",
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MapScreen()));
              },
              style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(12)),
                  minimumSize:
                      WidgetStateProperty.all<Size>(const Size(400, 11)),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFFC67C4E)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.grey)))),
              child: const Text(
                "Xem thông tin giao hàng",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
