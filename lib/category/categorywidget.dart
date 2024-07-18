import 'dart:async';
import 'dart:convert';
<<<<<<< HEAD
=======
import 'package:app_coffee/home/details.dart';
import 'package:http/http.dart' as http;
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459
import 'package:app_coffee/congf/const.dart';
import 'package:http/http.dart' as http;
import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:app_coffee/data/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/config/config_manager.dart';
import '../data/service/product_service.dart';
import '../data/service/product_service.dart';


class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, dynamic>> categories = [];
  List<dynamic> products = [];
  bool isLoading = true;
  String selectedCategory = "Cappuchino";
<<<<<<< HEAD
  
=======
  int selectedCategoryId = 1;
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchCategorieProducts(selectedCategory);
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseURL/api/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["data"];
<<<<<<< HEAD
        final List<String> fetchedCategories = ["Cappuchino"];
        for (var category in data) {
          final String categoryName = category["catName"];
          if (!fetchedCategories.contains(categoryName)) {
            fetchedCategories.add(categoryName);
=======
        final List<Map<String, dynamic>> fetchedCategories = [
          {"id": 1, "name": "Cappuchino"}
        ];
        for (var category in data) {
          final Map<String, dynamic> categoryData = {
            "id": category["id"],
            "name": category["catName"]
          };
          if (!fetchedCategories
              .any((cat) => cat["name"] == categoryData["name"])) {
            fetchedCategories.add(categoryData);
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459
          }
        }
        setState(() {
          isLoading = false;
          categories = fetchedCategories;
        });
<<<<<<< HEAD
=======
        fetchCategorieProducts(1);
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchCategorieProducts(int categoryId) async {
    try {
<<<<<<< HEAD
      final response = await http.get(Uri.parse('$baseURL/api/products'));
      final List<dynamic> data = json.decode(response.body)["data"];
      final List<dynamic> categorieProducts = [];
      for (var prodouct in data) {
        final String productCategory = prodouct["catName"];
        if (productCategory == category) {
          categorieProducts.add(prodouct);
        }
=======
      final response =
          await http.get(Uri.parse('$baseURL/api/products/category/$categoryId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["data"];
        setState(() {
          selectedCategoryId = categoryId;
          products = data;
        });
      } else {
        throw Exception('Failed to load products');
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 30,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryId = category["id"];
                            });
                            fetchCategorieProducts(category["id"]);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
<<<<<<< HEAD
                              color: selectedCategory == category
=======
                              color: selectedCategoryId == category["id"]
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459
                                  ? const Color(0xFF7F4C2A)
                                  : Colors.white
                            ),
                            child: Center(
                              child: Text(
                                category["name"],
                                style: TextStyle(
                                  fontWeight: selectedCategoryId == category["id"]
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: selectedCategoryId == category["id"]
                                      ? Colors.white
                                      : const Color(0xFFCCC9C9),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.79,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return itemProdView(product, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemProdView(dynamic product, BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final provider_1 = CartProvider.of(context);
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
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: IconButton(
              onPressed: () {
                provider.toggleFavorites(product);
              },
              icon: Icon(
                provider.isExist(product)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.01),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyFoodScreen(
                      product: product,
                    ),
                  ),
                );
              },
              child: Image.asset(urlimg + product["img"],
                height: 110,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.1),
            child: Text(
              product["name"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.1),
            child: Text(
              product["des"],
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
              const SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.1),
                child: Text(
                  NumberFormat('###,###,### VND').format(product["price"]),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  selectionColor: const Color.fromARGB(255, 0, 0, 1),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.1),
                child: ElevatedButton(
                  onPressed: () {
                    provider_1.addToCart(product);
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(3)),
                    minimumSize:
                        WidgetStateProperty.all<Size>(const Size(24.25, 23)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFFA67B5B)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
