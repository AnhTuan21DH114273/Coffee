import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
  final List<dynamic> _order = [];
  List<dynamic> get order => _order;

  void buyNow(dynamic products) {
    if (_order.contains(products)) {
      _order.remove(products);
    } else {
      _order.add(products);
    }
    notifyListeners();
  }

  int get itemCount => _order.length;

  double calculateTotal(List<dynamic> cartList) {
    double totalPrice = 0;
    for (var item in cartList) {
      totalPrice += item.quantity * item.product.price;
    }
    return totalPrice;
  }
}
