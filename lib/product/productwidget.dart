import 'dart:convert';
import 'package:app_coffee/data/config/config_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../data/provider/order_provider.dart';
import '../order/order_screen.dart';
import '../data/model/product.dart';
import 'package:http/http.dart' as http;

class ProductWidget extends StatefulWidget {
  final int objCat;

  const ProductWidget({
    Key? key,
    required this.objCat,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  late PageController _pageController;
  List<ProductModel> products = [];
  int selected = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    fetchProducts(widget.objCat);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts(int catId) async {
    final apiUrl = '$baseURL/products/category/$catId';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          products = data.map((item) => ProductModel.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: PageView.builder(
          controller: _pageController,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductScreen(product);
          },
        ),
      ),
    );
  }

  Widget _buildProductScreen(ProductModel product) {
    final provider = Provider.of<OrderProvider>(context);
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFE3E3E3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _colorFromHex(product.color),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(300),
                bottomRight: Radius.circular(300),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "DETAILS",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.buyNow(product);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      minimumSize: const Size(44, 44),
                      backgroundColor: const Color(0xFF533A28),
                    ),
                    child: SvgPicture.asset("assets/vectors/Heart.svg"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/' + product.img,
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              product.des,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 1,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              product.desc,
              style: const TextStyle(fontSize: 14, color: Color(0xFFA2A2A2)),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Size",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          sizeButton(),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.bottomCenter,
            height: 113,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Price",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${product.price}",
                        style:
                            const TextStyle(fontSize: 20, color: Color(0xFFD14946)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderScreen(prodId: product.id)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      minimumSize: const Size(217, 56),
                      backgroundColor: const Color(0xFFC67C4E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: const Text(
                      "Buy Now",
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        : const Color(0xFFE3E3E3)),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: selected == index ? const Color(0xFFF9F2ED) : Colors.white,
              ),
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 14,
                  color: selected == index ? const Color(0xFFC67C4E) : Colors.black,
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
