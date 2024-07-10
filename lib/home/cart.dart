import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool checkboxValue1 = false;
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final counter = Provider.of<CartCounter>(context);
    final cartlist = provider.cartList;
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Container(
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
                    icon: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 130,
                  ),
                  const Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 140,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        minimumSize: const Size(44, 44),
                        backgroundColor: const Color(0xFF533A28),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: 550,
                child: ListView.builder(
                itemCount: cartlist.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final cartList = cartlist[index];
                  return Container(
                    height: 92,
                    width: 412,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          activeColor: Color(0xFFC3916B),
                          value: checkboxValue1,
                          onChanged: (value) {
                            setState(() {
                              checkboxValue1 = value!;
                            });
                          },
                        ),
                        Image.asset(urlimg + cartList["img"]),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 25),
                            Text(cartList["name"]),
                            Text(
                              cartList["des"],
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
                          provider.removeFromCart(cartList);
                        }, 
                        icon: Icon(Icons.delete, color: Colors.red,))
                      ],
                    ),
                  );
                },
              )),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  minimumSize: const Size(400, 10),
                  backgroundColor: const Color(0xFFC67C4E),
                ),
                child: const Text(
                  "CONTINUE",
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
          )),
    );
  }
}
