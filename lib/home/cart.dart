import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/provider/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Container(
        color: Colors.grey.shade300,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 120),
                const Text(
                  "Giỏ hàng",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
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
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  final cartItem = cartList[index];
                  return Container(
                    height: 92,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFFC3916B),
                          value: cartItem.isChecked,
                          onChanged: (value) {
                            cartProvider.toggleCheckbox(cartItem.product);
                          },
                        ),
                        Image.asset(
                          'assets/images/${cartItem.product.img}',
                          width: 60, // Thay đổi kích thước hình ảnh nếu cần
                          height: 60,
                          fit: BoxFit
                              .cover, // Đảm bảo hình ảnh không bị biến dạng
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cartItem.product.name),
                              Text(
                                cartItem.product.des,
                                style: const TextStyle(
                                  color: Color(0xFFA2A2A2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cartProvider.decreaseQuantity(cartItem.product);
                          },
                        ),
                        Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cartProvider.increaseQuantity(cartItem.product);
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            cartProvider.removeFromCart(cartItem.product);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFFC67C4E),
              ),
              child: const Text(
                "Tiếp tục",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
