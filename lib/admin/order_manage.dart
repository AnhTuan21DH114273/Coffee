import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/service/order_service.dart';
import '../data/model/order.dart';
import '../admin/order/editOrder.dart'; // Import the edit order screen

class OrderManage extends StatefulWidget {
  const OrderManage({super.key});

  @override
  State<OrderManage> createState() => _OrderManageState();
}

class _OrderManageState extends State<OrderManage> {
  List<OrderModel> orders = [];
  final OrderService _orderService = OrderService(); // Initialize OrderService

  @override
  void initState() {
    super.initState();
    getOrders(); // Fetch orders when the widget is initialized
  }

  Future<void> getOrders() async {
    try {
      final orderList = await _orderService.fetchOrders();
      setState(() {
        orders = orderList;
      });
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: orders.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return listView(order, context);
                },
              ),
      ),
    );
  }

  Widget listView(OrderModel order, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đơn hàng: ${order.id}",
                  style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold
                  ),
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: 'Tổng tiền: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: NumberFormat('###,###.### VNĐ')
                          .format(order.totalAmount),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ))
                ])),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: 'Trạng thái: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: order.status,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ))
                ])),
                Text(
                    "Ngày đặt hàng: ${order.orderDate.toLocal().toString().split(' ')[0]}",
                    style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOrder(order: order),
                ),
              ).then((_) {
                getOrders(); // Refresh the list after editing
              });
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.yellow,
            ),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmation(order.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa đơn hàng này?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                try {
                  await _orderService.deleteOrder(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đơn hàng đã được xóa')),
                  );
                  getOrders(); // Refresh the list
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Xóa đơn hàng thất bại: $e')),
                  );
                }
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}
