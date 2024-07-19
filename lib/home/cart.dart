import 'dart:convert';

import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/config/config_manager.dart';
import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:app_coffee/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> products = [];
  int prodId = 1;
  Future<void> getProdbyId(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseURL/api/products/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["data"];
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
      }  else {
        throw Exception('Failed to load products');
      }
      } catch (e) {
        print(e);
      }
  }
  @override
  void initState() {
    super.initState();
    getProdbyId(prodId);
  }
  bool checkboxValue1 = false;
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final counter = Provider.of<CartCounter>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: FutureBuilder(
        future: getProdbyId(prodId), 
        builder: (context, snapshot) {
          return Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  const Text(
                    "Giỏ hàng",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        minimumSize: const Size(44, 44),
                        backgroundColor: const Color(0xFF533A28),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: 590,
                child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Column(
                    children: [
                      Container(
                        height: 92,
                        width: 420,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              activeColor: const Color(0xFFC3916B),
                              value: checkboxValue1,
                              onChanged: (value) {
                                setState(() {
                                  checkboxValue1 = value!;
                                });
                              },
                            ),
                            Image.asset(urlimg + product["img"]),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 25),
                                Text(product["name"]),
                                Text(
                                  product["des"],
                                  style: const TextStyle(
                                    color: Color(0xFFA2A2A2),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: counter.decreQuan),
                            ),
                            Text(
                              '${counter.count}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: counter.increQuan),
                            IconButton(onPressed: (){
                              setState(() {
                                provider.removeFromCart(product);
                              });
                            }, 
                            icon: const Icon(Icons.delete, color: Colors.red,)),
                          ],
                        ),
                      ),
                      SizedBox(height: 400,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen(prodId: product["id"])));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            minimumSize: const Size(400, 10),
                            backgroundColor: const Color(0xFFC67C4E),
                          ),
                          child: const Text(
                            "Tiếp tục",
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
                  );
                },
              ))
            ],
          ));
        },
      )
    );
  }
}
