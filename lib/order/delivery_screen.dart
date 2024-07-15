import 'dart:convert';
import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:app_coffee/home/voucher.dart';
import 'package:app_coffee/successful/order.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  final int prodId;
  const DeliveryScreen({super.key, required this.prodId});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List<dynamic> products = [];
  Future<void> getProdbyId(int id) async {
    try {
      final String response =
          await rootBundle.loadString("assets/files/product.json");
      final List<dynamic> data = json.decode(response)["data"];
      final List<dynamic> categorieProducts = [];
      for (var prdouct in data) {
        final int productCategory = prdouct["id"];
        if (productCategory == id) {
          categorieProducts.add(prdouct);
        }
      }
      setState(() {
        products = categorieProducts;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProdbyId(widget.prodId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
          padding: const EdgeInsets.only(left: 10),
          color: Colors.grey.shade300,
          child: FutureBuilder(
            future: getProdbyId(widget.prodId),
            builder: (context, snapshot) {
              return PageView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildScreen(product, context);
                },
              );
            },
          )),
    );
  }

  Widget _buildScreen(product, BuildContext context) {
    double deliveryFee = 15000;
    final counter = Provider.of<CartCounter>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "15 Võ Văn Kiệt",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Nguyễn Văn A",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "phường 7, quận 6, Thành phố Hồ Chí Minh",
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFA2A2A2),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
                width: 140,
                height: 26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFA2A2A2))),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Icon(Icons.edit),
                    SizedBox(
                      width: 6,
                    ),
                    Text("Edit Address"),
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            Container(
                width: 105,
                height: 26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFA2A2A2))),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Icon(Icons.note),
                    SizedBox(
                      width: 6,
                    ),
                    Text("Add Note"),
                  ],
                )),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 9.0, right: 9.0),
            child: const Divider(
              color: Color(0xFFE3E3E3),
              height: 30,
            )),
        Container(
          width: 412,
          height: 68,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                urlimg + product["img"],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product["name"],
                  ),
                  Text(
                    product["des"],
                  ),
                ],
              ),
              SizedBox(
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: counter.decreQuan),
              ),
              Padding(
                padding: EdgeInsets.only(top: 9),
                child: Text(
                  '${counter.count}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.add), onPressed: counter.increQuan),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 411,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEDEDED))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.discount_outlined,
                color: Color(0xFFC67C4E),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "1 Discount is Applies",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 178,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Voucher()));
                  },
                  icon: const Icon(Icons.arrow_forward)),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Payment Summary",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Price:",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF313131),
              ),
            ),
            const SizedBox(
              width: 310,
            ),
            Text(
              NumberFormat("##,###.###")
                  .format(product["price"] * counter.count),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Delivery Fee:",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF313131),
              ),
            ),
            const SizedBox(
              width: 260,
            ),
            Text(
              NumberFormat("##,###.###").format(deliveryFee),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const DottedLine(
          dashColor: Colors.black87,
          lineLength: 410,
          lineThickness: 1.5,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Total:",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF313131),
              ),
            ),
            const SizedBox(
              width: 310,
            ),
            Text(
              NumberFormat("##,###.###")
                  .format(deliveryFee + (product["price"] * counter.count)),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
        Container(
          width: 432,
          height: 185,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${counter.count} Products",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 190,
                  ),
                  Text(
                    NumberFormat("##,###.###").format(
                        deliveryFee + (product["price"] * counter.count)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderSuccessful()));
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
                  "Order",
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
      ],
    );
  }
}
