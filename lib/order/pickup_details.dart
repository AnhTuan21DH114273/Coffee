// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/config/config_manager.dart';
import 'package:app_coffee/data/model/shop.dart';
import 'package:app_coffee/data/provider/cart_provider.dart';
import 'package:app_coffee/home/favorite.dart';
import 'package:app_coffee/home/voucher.dart';
import 'package:app_coffee/successful/order.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickupDetails extends StatefulWidget {
  final int shopId;
  const PickupDetails({super.key, required this.shopId});

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  Shop? _shop;
  Future<Shop?> getShopById(int id) async {
    try {
      // Find the shop with the given id in the shopList
      Shop? shop = shopList.firstWhere((s) => s.id == id);
      return shop;
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error getting shop: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getShopDetails();
  }

  Future<void> _getShopDetails() async {
    Shop? shop = await getShopById(widget.shopId);
    setState(() {
      _shop = shop;
    });
  }

  Future<void> _placeOrder() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartList = cartProvider.cartList;
    double deliveryFee = 15000;
    String? userId;
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    // Thông tin đơn hàng
    final order = {
      'user_id':
          userId, // Ví dụ: ID người dùng, bạn có thể lấy từ state hoặc auth
      'address': _shop?.address,
      'order_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'total_price': cartList.fold<double>(
          0, (sum, item) => sum + item.product.price * item.quantity),
      'delivery_fee': deliveryFee,
      'total_amount': cartList.fold<double>(
              0, (sum, item) => sum + item.product.price * item.quantity) +
          deliveryFee,
      'payment_method': 'Tiền mặt', // Ví dụ: phương thức thanh toán
      'status': 'Chờ nhận hàng',
      'items': cartList
          .map((item) => {
                'product_id': item.product.id,
                'product_name': item.product.name,
                'product_description': item.product.des,
                'quantity': item.quantity,
                'price': item.product.price,
              })
          .toList(),
    };

    try {
      final response = await http.post(
        Uri.parse('$baseURL/api/orders'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(order),
      );
      print('API response: ${response.body}');
      if (response.statusCode == 201) {
        // Giả sử rằng ID đơn hàng được trả về trong phản hồi
        final responseData = json.decode(response.body);
        final orderId = responseData['orderId']; // Lấy order_id từ phản hồi
        print('Order placed successfully with ID: $orderId');
        // Chèn các mục vào bảng order_items
        final itemsResponse = await http.post(
          Uri.parse('$baseURL/api/order_items'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'order_id': orderId,
            'items': cartList
                .map((item) => {
                      'product_id': item.product.id,
                      'product_name': item.product.name,
                      'product_description': item.product.des,
                      'quantity': item.quantity,
                      'price': item.product.price,
                    })
                .toList(),
          }),
        );
        print('Order items response: ${itemsResponse.statusCode}');
        if (itemsResponse.statusCode == 201) {
          // Đơn hàng và các mục đã được tạo thành công
          cartProvider.clearCart();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OrderSuccessful()));
        } else {
          // Xử lý lỗi nếu không thể chèn các mục
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error placing order items')),
          );
        }
      } else {
        // Xử lý lỗi nếu đơn hàng không được tạo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error placing order')),
        );
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error connecting to server')),
      );
    }
  }

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
      appBar: AppBar(
        title: const Text("Lấy hàng"),
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Favorite()));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(14),
              minimumSize: const Size(44, 44),
              backgroundColor: const Color(0xFF533A28),
            ),
            child: SvgPicture.asset("assets/vectors/Heart.svg"),
          ),
          const Padding(padding: EdgeInsets.only(left: 9))
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          color: Colors.grey.shade100,
          child: cartList.isEmpty
              ? const Center(child: Text('Giỏ hàng của bạn đang trống'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAddressSection(),
                    _buildCartSummary(totalQuantity, totalPrice, deliveryFee),
                    _buildPaymentSummary(totalPrice, deliveryFee),
                    _buildCheckoutButton(context, cartProvider),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          "${_shop?.name}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${_shop?.address}",
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFA2A2A2),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "15 - 30 phút",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Text(
          "Sớm nhất có thể",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey
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
              width: 145,
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
                  Text("Thêm ghi chú"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildCartSummary(
      int totalQuantity, double totalPrice, double deliveryFee) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
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
              Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                product.des,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            padding: const EdgeInsets.only(top: 3),
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
              NumberFormat("###,###.### VND").format(totalPrice),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
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
              NumberFormat("###,###.### VND").format(deliveryFee),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
          ],
        ),
        const SizedBox(height: 15),
        const DottedLine(
            dashColor: Colors.black87, lineLength: 410, lineThickness: 1.5),
        const SizedBox(height: 25),
        Row(
          children: [
            const Text(
              "Tổng:",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF313131),
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              NumberFormat("###,###.### VND").format(totalPrice + deliveryFee),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context, CartProvider cartProvider) {
    return Container(
      width: double.infinity,
      height: 195,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 10),
              const Text(
                "Giao hàng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                "${cartProvider.cartList.fold<int>(0, (sum, item) => sum + item.quantity)} sản phẩm",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                NumberFormat("###,###.### VND").format(
                  15000 +
                      cartProvider.cartList.fold<double>(
                          0,
                          (sum, item) =>
                              sum + item.product.price * item.quantity),
                ),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _placeOrder();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Đặt hàng thành công')),
              );
            },
            style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
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
              "Đặt hàng",
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
