import 'package:flutter/material.dart';

class ProductModel {
  int id;
  String name;
  String des;
  String desc;
  double price;
  String img;
  String catName;
  int catId;
  final String color;

  ProductModel({
    required this.id,
    required this.name,
    required this.des,
    required this.desc,
    required this.price,
    required this.img,
    required this.catName,
    required this.catId,
    required this.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      des: json['des'],
      desc: json['desc'],
      price: json['price'].toDouble(),
      img: json['img'],
      catName: json['catName'],
      catId: json['catId'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'des': des,
      'desc': desc,
      'price': price,
      'img': img,
      'catName': catName,
      'catId': catId,
      'color': color,
    };
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> fde5943b1213fdc63634e40d46a750aeaf283459
