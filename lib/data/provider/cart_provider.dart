import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier{
  final List<dynamic> _cartList = [];
  
  List<dynamic> get cartList => _cartList;
  final bool _items = false;
  bool get items => _items;
  void addToCart(dynamic products){
    _cartList.add(products);
    notifyListeners();
  }
  void removeFromCart(dynamic products){
    _cartList.remove(products);
    notifyListeners();
  }
  
  static CartProvider of(BuildContext context, {bool listen = true}){
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}

class CartCounter with ChangeNotifier{
  bool items = false;
  int _count = 1;
  int get count => _count;
  void increQuan(){
    if(_count >=1){
      _count++;
    }
    notifyListeners();
  }
  void decreQuan(){
    if(_count > 1){
      _count--;
    }
    notifyListeners();
  }
}