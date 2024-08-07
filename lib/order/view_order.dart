import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/config/config_manager.dart';
import 'order_detail.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  List<dynamic> orders = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId == null) {
        setState(() {
          errorMessage = 'User ID not found';
          isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('$baseURL/api/orders/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${prefs.getString('userToken')}', // Optional: if token is needed
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data'); // Log the data received
        if (data is Map<String, dynamic> && data.containsKey('orders')) {
          setState(() {
            orders = data['orders'] is List ? data['orders'] : [];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Unexpected data format';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load orders: ${response.body}';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error occurred: $e'); // Log the error
      setState(() {
        errorMessage = 'An error occurred';
        isLoading = false;
      });
    }
  }

  Future<void> _navigateToOrderDetail(String orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse('$baseURL/api/order/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${prefs.getString('userToken')}', // Optional: if token is needed
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Order detail received: $data'); // Log the data received
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetail(order: data['order']),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Failed to load order detail: ${response.body}';
        });
      }
    } catch (e) {
      print('Error occurred: $e'); // Log the error
      setState(() {
        errorMessage = 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin đơn hàng'),
        centerTitle: true,
        backgroundColor: Colors.white
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Container(
                color: Colors.grey.shade100,
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    print('Order: $order'); // Log each order to verify data
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(20.0),
                      elevation: 4.0,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(20.0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            '${order['id']}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        title: Text(
                          'Mã đơn hàng: ${order['id']}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày đặt hàng: ${order['order_date']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Tổng:',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  NumberFormat('###,###.### VND').format(order['total_amount']),
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            _navigateToOrderDetail(order['id'].toString());
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
    );
  }
}
