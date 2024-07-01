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
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Container(
            height: 340,
            decoration: const BoxDecoration(color: Color(0xFFC3916B)),
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                ),
                const Positioned(
                    top: 38,
                    right: 170,
                    child: Text(
                      "Voucher",
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
                    top: 160,
                    left: 13,
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Text(
                          "0 bean",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    top: 160,
                    right: 13,
                    child: Container(
                      height: 26,
                      width: 115,
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
                            "Your voucher",
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
                    top: 200,
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
                    top: 300,
                    left: 10,
                    child: Container(
                      width: 187,
                      color: Colors.transparent,
                      child: const Text(
                        "100 more beans left and you will advance. Redeeming gifts does not affect promotion.",
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
            height: 10,
          ),
          SizedBox(
            height: 250,
            child: GridView.builder(
                itemCount: voucherGrid.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.3,
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
          Expanded(
              child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                  width: 412,
                  height: 106,
                  margin: EdgeInsets.all(10),
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
