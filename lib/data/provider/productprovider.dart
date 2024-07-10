import '../model/productlist.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ReadDataProd {
  Future<List<Product>> loadData() async {
    var data = await rootBundle.loadString("assets/files/product.json");
    var dataJson = jsonDecode(data);
    return (dataJson['data'] as List).map((e) => Product.fromJson(e)).toList();
  }
  Future<Iterable<Product>> loadDataByCat (int catId) async{
    var data = await rootBundle.loadString("assets/files/product.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List).map((e)=> Product.fromJson(e)).where((e) => e.catId == catId).toList();
  }
}

