import 'package:intl/intl.dart';

class OrderModel {
  final int id;
  final int userId;
  final String address;
  final DateTime orderDate;
  final double totalPrice;
  final double deliveryFee;
  final double totalAmount;
  final String paymentMethod;
  final String status;
  final String? notes;

  OrderModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.orderDate,
    required this.totalPrice,
    required this.deliveryFee,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    this.notes,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      orderDate: DateTime.parse(json['order_date']),
      totalPrice: json['total_price'].toDouble(),
      deliveryFee: json['delivery_fee'].toDouble(),
      totalAmount: json['total_amount'].toDouble(),
      paymentMethod: json['payment_method'],
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address': address,
      'order_date': DateFormat("yyyy-MM-ddTHH:mm:ss").format(orderDate),
      'total_price': totalPrice,
      'delivery_fee': deliveryFee,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'status': status,
      'notes': notes,
    };
  }
}
