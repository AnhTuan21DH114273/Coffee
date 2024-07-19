import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  void addProductFromJson(Map<String, dynamic> json) {
    try {
      // Chuyển đổi JSON thành ProductModel
      ProductModel product = ProductModel.fromJson(json);

      // Thêm sản phẩm vào giỏ hàng
      addToCart(product);
    } catch (e) {
      print('Lỗi khi thêm sản phẩm vào giỏ hàng từ JSON: $e');
    }
  }


  void addToCart(ProductModel product) {
    var existingItemIndex =
        _cartList.indexWhere((item) => item.product.id == product.id);
    if (existingItemIndex != -1) {
      _cartList[existingItemIndex].quantity++;
    } else {
      _cartList.add(CartItem(product: product, quantity: 1, isChecked: false));
    }
    notifyListeners();
  }


  void removeFromCart(ProductModel product) {
    _cartList.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    var itemIndex =
        _cartList.indexWhere((item) => item.product.id == product.id);
    if (itemIndex != -1) {
      _cartList[itemIndex].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductModel product) {
    var itemIndex =
        _cartList.indexWhere((item) => item.product.id == product.id);
    if (itemIndex != -1 && _cartList[itemIndex].quantity > 1) {
      _cartList[itemIndex].quantity--;
      notifyListeners();
    }
  }

  void toggleCheckbox(ProductModel product) {
    var itemIndex =
        _cartList.indexWhere((item) => item.product.id == product.id);
    if (itemIndex != -1) {
      _cartList[itemIndex].isChecked = !_cartList[itemIndex].isChecked;
      notifyListeners();
    }
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }
}

class CartItem {
  final ProductModel product;
  int quantity;
  bool isChecked;

  CartItem({required this.product, this.quantity = 1, this.isChecked = false});
}
