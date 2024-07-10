import 'dart:convert';
import 'dart:math';
import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/order_provider.dart';
import 'package:app_coffee/home/favorite.dart';
import 'package:app_coffee/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final int objCat;
  // ignore: use_super_parameters
  const ProductWidget({
    Key? key,
    required this.objCat,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  List<dynamic> products = [];
  late PageController _pageController;
  int selected = 0;
  Future<void> fetchProducts(int catId) async {
    try {
      final String response =
          await rootBundle.loadString("assets/files/product.json");
      final List<dynamic> data = json.decode(response)["data"];
      final List<dynamic> categorieProducts = [];
      for (var prdouct in data) {
        final int productCategory = prdouct["catId"];
        if (productCategory == catId) {
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
    super.initState();
    _pageController = PageController(initialPage: products.length * 999);
    fetchProducts(widget.objCat);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  double get _currentOffset {
    bool inited = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return inited ? _pageController.page! : _pageController.initialPage * 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.maxFinite,
          child: FutureBuilder(
            future: fetchProducts(widget.objCat),
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

  Widget _buildScreen(products, BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE3E3E3),
      ),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                  child: Container(
                alignment: Alignment.topCenter,
                height: 260,
                decoration: BoxDecoration(
                    color: Color.fromARGB(products["a"], products["r"],
                        products["g"], products["b"]),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(300),
                        bottomRight: Radius.circular(300))),
              )),
              Positioned(
                  child: Container(
                height: 350,
              )),
              const Positioned(
                  top: 50,
                  child: Text(
                    "DETAILS",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
              Positioned(
                top: 160,
                child: Image.asset(
                  urlimg + products["img"],
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 450,
            child: Row(
              children: [
                const SizedBox(width: 10,),
                SizedBox(
                  width: 350,
                  child: Text(
                    products["name"],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    provider.buyNow(products);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    minimumSize: const Size(44, 44),
                    backgroundColor: const Color(0xFF533A28),
                  ),
                  child: Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                ),
              ],
            )
          ),
          const Padding(
            padding: EdgeInsets.only(right: 380),
            child: Text(
              "Cold",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 9.0, right: 9.0),
              child: const Divider(
                color: Colors.black,
                height: 30,
              )),
          const Padding(
            padding: EdgeInsets.only(right: 320),
            child: Text(
              "Description",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 100, left: 15),
            child: SizedBox(
              width: 327,
              child: Text(
                products["des"],
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 370),
            child: Text(
              "Size",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          sizeButton(),
          const SizedBox(height: 109),
          Container(
            alignment: Alignment.bottomCenter,
            height: 113,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.white,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(
                width: 18,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "\$${products["price"]}",
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
                width: 120,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
                  },
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(12)),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(217, 56)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFC67C4E)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: Colors.grey)))),
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
              ),
            ]),
          )
        ],
      ),
    );
  }

  Padding sizeButton() {
    // list of times
    List list = ["S", "M", "L"];
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        height: 41,
        child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
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
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selected == index
                              ? Color(0xFFC67C4E)
                              : Color(0xFFE3E3E3)),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color:
                          selected == index ? Color(0xFFF9F2ED) : Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      list[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: selected == index
                            ? Color(0xFFC67C4E)
                            : Colors.black,
                        fontWeight: selected == index ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
/*GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return itemGridView(product);
                  })*/