import 'package:app_coffee/admin/order_manage.dart';
import 'package:app_coffee/admin/product_manage.dart';
import 'package:app_coffee/admin/user_manage.dart';
import 'package:app_coffee/signIn/signIn.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Color(0xFFC3916B),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInWidget()));
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Tạm biệt Admin nha')
                      ),
                    );
                  }, 
                  icon: const Icon(Icons.arrow_back, color: Colors.black,)),
                  const SizedBox(width: 75,),
                  const Text(
                  "Quản lý Admin",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 150,
            ),
            Container(
              height: 111,
              width: 430,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.transparent),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ProductManage()));
                  },
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(12)),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(400, 11)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFC67C4E)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: Color(0xFFC67C4E))))),
                  child: const Text(
                    "Quản lý sản phẩm",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 111,
              width: 430,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.transparent),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const OrderManage()));
                  },
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(12)),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(400, 11)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFC67C4E)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: Color(0xFFC67C4E))))),
                  child: const Text(
                    "Quản lý đơn hàng",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 111,
              width: 430,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.transparent),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const UserManager()));
                  },
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(12)),
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(400, 11)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFC67C4E)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: Color(0xFFC67C4E))))),
                  child: const Text(
                    "Quản lý tài khoản",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
