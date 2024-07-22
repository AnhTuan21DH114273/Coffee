import 'package:app_coffee/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/model/voucher.dart';

class Voucher extends StatefulWidget {
  const Voucher({super.key});

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            height: 280,
            decoration: const BoxDecoration(color: Color(0xFFC3916B)),
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Mainpage()));
                      }, icon: const Icon(Icons.arrow_back, color: Colors.black,)),
                ),
                const Positioned(
                    top: 38,
                    right: 130,
                    child: Text(
                      "Mã khuyến mãi",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )),
                Positioned(
                    top: 70,
                    right: 0,
                    child: Image.asset("assets/images/VoucherImg_1.png")),
                Positioned(
                    top: 60,
                    left: 0,
                    child: Image.asset("assets/images/VoucherImg_2.png")),
                Positioned(
                    top: 100,
                    left: 13,
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Text(
                          "200 Xu",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    top: 100,
                    right: 13,
                    child: Container(
                      height: 26,
                      width: 110,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(CupertinoIcons.ticket),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Mã của bạn",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    )),
                Positioned(
                    top: 140,
                    left: 10,
                    child: Container(
                      height: 93.16,
                      width: 412,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Column(
                        children: [
                          const SizedBox(
                            height: 13,
                          ),
                          Image.asset("assets/images/VoucherQR.png"),
                          const Text(
                            "CF12345678",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    )),
                Positioned(
                    top: 240,
                    left: 10,
                    child: Container(
                      width: 189,
                      color: Colors.transparent,
                      child: const Text(
                        "Còn 100 hạt đậu nữa và bạn sẽ tiến lên. Việc đổi quà không ảnh hưởng tới khuyến mãi.",
                        style: TextStyle(
                          color: Color(0xFFD9D9D9),
                          fontSize: 9,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 220,
            child: GridView.builder(
                itemCount: voucherGrid.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.65,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return Container(
                    height: 294,
                    width: 184,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.grey.shade100,
                          width: 1.5,
                        ),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, offset: Offset(0, 1)),
                        ]),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: SvgPicture.asset(voucherGrid[index].svg)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.1),
                          child: Text(
                            voucherGrid[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          const Padding(padding: EdgeInsets.only(right: 250),
            child: Text("Mã giảm giá của bạn",
            style: TextStyle(
              color: Color(0xFF7F4C2A),
              fontSize: 16,
              fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
              margin: const EdgeInsets.only(left: 9.0, right: 9.0),
              child: const Divider(
                color: Colors.grey,
                height: 1,
            )),
          Expanded(
            child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                  width: 412,
                  height: 100,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/images/Voucher.jpg"),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "Tuần lễ Coffee - Tea milk mua 1 tặng 1",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ));
            },
          )),
        ],
      ),
    );
  }
}
