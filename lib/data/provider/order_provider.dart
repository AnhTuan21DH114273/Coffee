import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier{
  final List<dynamic> _order = [];
  List<dynamic> get order => _order;
  void buyNow(dynamic products){
    if(_order.contains(products)){
      _order.remove(products);
    } else {
      _order.add(products);
    }
    notifyListeners();
  }
  int get itemCount => _order.length;
  String calculateTotal(dynamic products) {
    double totalPrice = 0;
    for (int i = 0; i < products.length; i++) {
      totalPrice += double.parse(products);
    }
    return totalPrice.toStringAsFixed(2);
  }
}