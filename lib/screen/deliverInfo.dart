import 'package:app_coffee/order/review.dart';
import 'package:flutter/material.dart';

class Deliverinfo extends StatefulWidget {
  const Deliverinfo({super.key});

  @override
  State<Deliverinfo> createState() => _DeliverinfoState();
}

class _DeliverinfoState extends State<Deliverinfo> {
  String selectedLanguage = 'Tiếng Việt';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 5,
          width: 45,
          decoration: BoxDecoration(
              color: const Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(16)),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "15 phút",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Giao cho",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF36C07E),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF36C07E),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF36C07E),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFE3E3E3),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 412,
          height: 77,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE3E3E3)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE3E3E3)),
                      color: Colors.white),
                  child: Image.asset("assets/images/Motor.png")),
              const SizedBox(
                width: 10,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Đang giao đơn đặt hàng của bạn",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 243,
                    child: Text(
                      "Chúng tôi sẽ giao hàng cho bạn trong thời gian ngắn nhất.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 120,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Review()));
          },
          style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
              minimumSize: WidgetStateProperty.all<Size>(const Size(400, 11)),
              backgroundColor:
                  WidgetStateProperty.all<Color>(const Color(0xFFC67C4E)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.grey)))),
          child: const Text(
            "Đã giao hàng",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.7,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
