import 'dart:async';
import 'dart:convert';
import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../product/productwidget.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<String> categories = [];
  List<dynamic> products = [];
  bool isLoading = true;
  String selectedCategory = "Cappuchino";

  Future<void> fetchCategories() async {
    try {
      final String response =
          await rootBundle.loadString("assets/files/categorylist.json");
      final List<dynamic> data = json.decode(response)["data"];
      final List<String> fetchdeCategories = ["Cappuchino"];
      for (var prdouct in data) {
        final String category = prdouct["catName"];
        if (!fetchdeCategories.contains(category)) {
          fetchdeCategories.add(category);
        }
      }
      setState(() {
        isLoading = false;
        categories = fetchdeCategories;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchCategorieProducts(String category) async {
    try {
      final String response =
          await rootBundle.loadString("assets/files/categorylist.json");
      final List<dynamic> data = json.decode(response)["data"];
      final List<dynamic> categorieProducts = [];

      for (var prdouct in data) {
        final String productCategory = prdouct["catName"];
        if (productCategory == category) {
          categorieProducts.add(prdouct);
        }
      }
      setState(() {
        selectedCategory = category;
        products = categorieProducts;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchCategorieProducts("Cappuchino");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
              height: 30,
              child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Container(
                      margin: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          fetchCategorieProducts(category);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: category == selectedCategory
                                ? const Color(0xFF7F4C2A)
                                : Colors.white,
                          ),
                          child: Center(
                              child: Text(
                            category,
                            style: TextStyle(
                                fontWeight: category == selectedCategory
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: category == selectedCategory
                                    ? Colors.white
                                    : Color(0xFFCCC9C9),
                                fontSize: 18),
                          )),
                        ),
                      ),
                    );
                  })),
          Expanded(
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.79,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return itemProdView(product, context);
                }),
          ),
        ],
      ),
    );
  }

  Widget itemProdView(products, BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Container(
      height: 294,
      width: 184,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
            padding: const EdgeInsets.only(left: 150),
            child: IconButton(
                onPressed: () {
                  provider.toggleFavorites(products);
                }, 
                icon: Icon(provider.isExist(products) ? Icons.favorite : Icons.favorite_border, color: Colors.red)),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 0.01,
            ),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductWidget(
                        objCat: products["catId"],
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  urlimg + products["img"],
                  height: 110,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.1),
            child: Text(
              products["name"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0.1),
            child: Text(
              products["des"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE6E6E6),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 0.1),
                  child: Text(
                    NumberFormat('###,###,### VND').format(products["price"]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    selectionColor: const Color.fromARGB(255, 0, 0, 1),
                  )),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.1),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(3)),
                        minimumSize: WidgetStateProperty.all<Size>(
                            const Size(24.25, 23)),
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFFA67B5B)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ))),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
