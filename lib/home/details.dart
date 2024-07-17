import 'dart:math';
import 'package:flutter/material.dart';
import '../data/model/product.dart';
import '../data/service/product_service.dart';

class MyFoodScreen extends StatefulWidget {
  final dynamic product; 

  const MyFoodScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<MyFoodScreen> createState() => _MyFoodScreenState();
}

class _MyFoodScreenState extends State<MyFoodScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late List<ProductModel> _foodList;

  ProductService _productService = ProductService();

  double get _currentOffset {
    bool initialized = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return initialized
        ? _pageController.page!
        : _pageController.initialPage * 1.0;
  }

  int get _currentIndex => _currentOffset.round() % _foodList.length;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    _fetchProducts();
    super.initState();
  }

  // Fetch products from API and update _foodList
  void _fetchProducts() async {
    try {
      List<ProductModel> products = await _productService.fetchProducts();
      setState(() {
        _foodList = products;
      });
    } catch (e) {
      // Handle error fetching products
      print('Failed to fetch products: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        width: double.maxFinite,
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            return _foodList != null && _foodList.isNotEmpty
                ? _buildScreen()
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildScreen() {
    final ProductModel _currentFood = _foodList[_currentIndex];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E3),
      ),
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
                    color: _colorFromHex(
                        _currentFood.color), // Assuming color is a hex string
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: 350,
                ),
              ),
              const Positioned(
                top: 50,
                child: Text(
                  "DETAILS",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 130,
                child: SizedBox(
                  height: 400,
                  width: 500,
                  child: PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      double _value = 0.0;
                      double vp = 1;
                      double scale = max(vp, (_currentOffset - index).abs());

                      if (_pageController.position.haveDimensions) {
                        _value = index.toDouble() - (_pageController.page ?? 0);
                        _value = (_value * 0.7).clamp(-1, 1);
                      }
                      return Transform.rotate(
                        angle: -0.4 * _value,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 200 - scale * 5),
                          child: FittedBox(
                            child: Image.network(
                              _foodList[index % _foodList.length]
                                  .img, // Assuming image is a URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _foodList.length,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 110),
            child: SizedBox(
              width: 300,
              child: Text(
                _currentFood.name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 380),
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
          Container(
            margin: const EdgeInsets.only(left: 9.0, right: 9.0),
            child: const Divider(
              color: Colors.black,
              height: 30,
            ),
          ),
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100, left: 15),
            child: SizedBox(
              width: 327,
              child: Text(
                _currentFood.desc,
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
          const SizedBox(
            height: 65,
          ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                      "\$${_currentFood.price}",
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
                    onPressed: () {},
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
                          side: const BorderSide(color: Colors.grey),
                        ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding sizeButton() {
    // List of sizes
    List<String> sizes = ["S", "M", "L"];
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        height: 41,
        child: ListView.builder(
          itemCount: sizes.length,
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
                          ? const Color(0xFFC67C4E)
                          : const Color(0xFFE3E3E3)),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: selected == index
                      ? const Color(0xFFF9F2ED)
                      : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    sizes[index],
                    style: TextStyle(
                      fontSize: 14,
                      color: selected == index
                          ? const Color(0xFFC67C4E)
                          : Colors.black,
                      fontWeight: selected == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
