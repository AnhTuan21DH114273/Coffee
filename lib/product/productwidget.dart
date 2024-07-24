import 'dart:convert';
import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/config/config_manager.dart';
import 'package:app_coffee/home/favorite.dart';
import 'package:app_coffee/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data/provider/cart_provider.dart';
import 'package:http/http.dart' as http;

class ProductWidget extends StatefulWidget {
  final int objCat;

  const ProductWidget({
    super.key,
    required this.objCat,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  late PageController _pageController;
  List<dynamic> products = [];
  int selected = 0;
  int selectedCategoryId = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    detailsByCatId(widget.objCat);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> detailsByCatId(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('$baseURL/api/products/category/$categoryId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["data"];
        setState(() {
          selectedCategoryId = categoryId;
          products = data;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: FutureBuilder(
          future: detailsByCatId(widget.objCat),
          builder: (context, snapshot) {
            return PageView.builder(
              controller: _pageController,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildScreen(product, context);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildScreen(products, BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE3E3E3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 280,
            width: 440,
            decoration: BoxDecoration(
              color: _colorFromHex(products["color"]),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(300),
                bottomRight: Radius.circular(300),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0, top: 20),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 105,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 0, top: 20),
                      child: Text(
                        "Chi tiết",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 130,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0, top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Favorite()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          minimumSize: const Size(44, 44),
                          backgroundColor: const Color(0xFF533A28),
                        ),
                        child: SvgPicture.asset("assets/vectors/Heart.svg"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  urlimg + products["img"],
                  height: 168,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              products["name"],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Cold",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                // Số điểm đánh giá
                Text(
                  '4.8', // Điểm đánh giá
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                    width: 5), // Khoảng cách giữa số điểm và icon sao
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(
                    width: 5), // Khoảng cách giữa icon sao và số người đánh giá
                Text(
                  '(283)', // Số người đánh giá
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 9.0, right: 9.0),
            child: const Divider(
              color: Colors.grey,
              height: 20,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Mô tả",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100, left: 10),
            child: Text(
              products["desc"],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA2A2A2),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Kích cỡ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          sizeButton(),
          Spacer(),
          Container(
            alignment: Alignment.centerLeft,
            height: 130,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Giá",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      NumberFormat("##,###.### VNĐ").format(products["price"]),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFFD14946),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      cartProvider.addProductFromJson(products);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(12)),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(217, 56)),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(const Color(0xFFC67C4E)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Mua Ngay",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.7,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Widget sizeButton() {
    List<String> sizes = ["S", "M", "L"]; // Example sizes
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(
        children: sizes.map((size) {
          int index = sizes.indexOf(size);
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 41,
              width: 96,
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected == index
                      ? const Color(0xFFC67C4E)
                      : const Color(0xFFE3E3E3),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color:
                    selected == index ? const Color(0xFFF9F2ED) : Colors.white,
              ),
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 14,
                  color: selected == index
                      ? const Color(0xFFC67C4E)
                      : Colors.black,
                  fontWeight:
                      selected == index ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
