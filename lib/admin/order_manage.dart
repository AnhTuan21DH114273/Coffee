import 'package:flutter/material.dart';

class OrderManage extends StatefulWidget {
  const OrderManage({super.key});

  @override
  State<OrderManage> createState() => _OrderManageState();
}

class _OrderManageState extends State<OrderManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
        centerTitle: true,
      ),
    );
  }
}