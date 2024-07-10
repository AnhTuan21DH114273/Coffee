import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier{
  final List<dynamic> _favorite = [];
  List<dynamic> get favorite => _favorite;
  void toggleFavorites(dynamic products){
    if(_favorite.contains(products)){
      _favorite.remove(products);
    } else {
      _favorite.add(products);
    }
    notifyListeners();
  }
  bool isExist(dynamic products){
    final isExist = _favorite.contains(products);
    return isExist;
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}){
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}