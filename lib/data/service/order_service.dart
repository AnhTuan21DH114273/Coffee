import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/order.dart';
import '../config/config_manager.dart';

class OrderService {
  final String baseUrl = '$baseURL/api/orders'; // Update with your API base URL

  Future<List<OrderModel>> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the response is a Map and has a key for the orders
        if (data is Map<String, dynamic> && data.containsKey('orders')) {
          final List<dynamic> orderList = data['orders'];
          return orderList.map((json) => OrderModel.fromJson(json)).toList();
        } else if (data is List<dynamic>) {
          // Handle case where the response is a direct list
          return data.map((json) => OrderModel.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }


  Future<void> deleteOrder(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete order: $e');
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${order.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': order.userId,
          'address': order.address,
          'order_date':
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(order.orderDate),
          'total_price': order.totalPrice,
          'delivery_fee': order.deliveryFee,
          'total_amount': order.totalAmount,
          'payment_method': order.paymentMethod,
          'status': order.status,
          'notes': order.notes,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update order: $e');
    }
  }
}
