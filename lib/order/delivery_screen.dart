import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:app_coffee/home/voucher.dart';
import 'package:app_coffee/successful/order.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    double deliveryFee = 15000;

    // Tính tổng số lượng và giá
    double totalPrice = 0;
    int totalQuantity = 0;

    for (final cartItem in cartList) {
      totalPrice += cartItem.product.price * cartItem.quantity;
      totalQuantity += cartItem.quantity;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.grey.shade300,
        child: cartList.isEmpty
            ? Center(child: Text('Giỏ hàng của bạn đang trống'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAddressSection(),
                  _buildCartSummary(totalQuantity, totalPrice, deliveryFee),
                  _buildPaymentSummary(totalPrice, deliveryFee),
                  _buildCheckoutButton(context),
                ],
              ),
      ),
    ));
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "15 Võ Văn Kiệt",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Nguyễn Văn A",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "phường 7, quận 6, Thành phố Hồ Chí Minh",
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFA2A2A2),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 130,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFA2A2A2)),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 6),
                  Icon(Icons.edit),
                  SizedBox(width: 6),
                  Text("Sửa địa chỉ"),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 105,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFA2A2A2)),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 6),
                  Icon(Icons.note),
                  SizedBox(width: 6),
                  Text("Ghi Note"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildCartSummary(
      int totalQuantity, double totalPrice, double deliveryFee) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Danh sách sản phẩm",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          for (var cartItem in Provider.of<CartProvider>(context).cartList)
            _buildCartItem(cartItem),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEDEDED)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.discount_outlined, color: Color(0xFFC67C4E)),
                const SizedBox(width: 10),
                const Text(
                  "1 thẻ giảm giá được áp dụng",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Voucher()));
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem cartItem) {
    final product = cartItem.product;
    return Container(
      width: double.infinity,
      height: 68,
      color: Colors.transparent,
      child: Row(
        children: [
          Image.asset(
            urlimg + product.img,
          ),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(product.name),
              Text(product.des),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .decreaseQuantity(product);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Text(
              '${cartItem.quantity}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .increaseQuantity(product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(double totalPrice, double deliveryFee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tóm tắt thanh toán",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Text(
              "Giá:",
              style: TextStyle(fontSize: 16, color: Color(0xFF313131)),
            ),
            const Spacer(),
            Text(
              NumberFormat("##,###.###").format(totalPrice),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Text(
              "Giá giao hàng:",
              style: TextStyle(fontSize: 16, color: Color(0xFF313131)),
            ),
            const Spacer(),
            Text(
              NumberFormat("##,###.###").format(deliveryFee),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const DottedLine(
            dashColor: Colors.black87, lineLength: 410, lineThickness: 1.5),
        const SizedBox(height: 15),
        Row(
          children: [
            const Text(
              "Tổng:",
              style: TextStyle(fontSize: 16, color: Color(0xFF313131)),
            ),
            const Spacer(),
            Text(
              NumberFormat("##,###.###").format(totalPrice + deliveryFee),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              const Text(
                "Giao",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                "${Provider.of<CartProvider>(context).cartList.fold<int>(0, (sum, item) => sum + item.quantity)} Sản Phẩm",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                NumberFormat("##,###.###").format(
                  15000 +
                      Provider.of<CartProvider>(context).cartList.fold<double>(
                          0,
                          (sum, item) =>
                              sum + item.product.price * item.quantity),
                ),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderSuccessful()));
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(12)),
              minimumSize: WidgetStateProperty.all<Size>(const Size(400, 11)),
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
              "Order",
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
    );
  }
}
