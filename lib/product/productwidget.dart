import 'dart:convert';
import 'package:app_coffee/congf/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  List<String> categories = [];
  List<dynamic> products = [];
  Future<void> fetchCategorieProducts(int catId) async {
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
    fetchCategorieProducts(widget.objCat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: fetchCategorieProducts(widget.objCat),
            builder: (context, snapshot) {
              return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return itemGridView(product);
                  });
            },
          )),
    );
  }

  Widget itemGridView(products) {
    return Container(
      //padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.lightBlue,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Image.asset(
                urlimg + products["img"],
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              )),
          Text(
            products["name"],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            NumberFormat('###,###,###').format(products["price"]),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
            selectionColor: const Color.fromARGB(255, 0, 0, 1),
          )
        ],
      ),
    );
  }
}
