import 'package:flutter/material.dart';
class FoodModel {
  String name;
  String desc;
  double price;
  String image;
  final Color color;
  FoodModel({
    required this.name,
    required this.desc,
    required this.price,
    required this.image,
    required this.color,
  });
}

List<FoodModel> foodList = [
  FoodModel(
    name: 'Machiato with Milk',
    desc: 'A Machiato with Milk is an approximately 120 ml (4 oz) beverage, with 15 ml of espresso coffee and 85ml of fresh milk.',
    price: 60.000,
    image: 'assets/images/Machiato_Milk.png',
    color: Color(0xFFCFB07A),
  ),
  FoodModel(
    name: 'Machiato',
    desc: 'A Machiato is an approximately 130 ml (4 oz) beverage, with 15 ml of espresso coffee and 85ml of fresh milk.',
    price: 60.000,
    image: 'assets/images/Machiato.png',
    color: Color(0xFFB57A51),
  ),
  FoodModel(
    name: 'Machiato with Vanilla',
    desc: 'A Machiato with Vanilla is an approximately 110 ml (4 oz) beverage, with 15 ml of espresso coffee and 85ml of fresh milk.',
    price: 60.000,
    image: 'assets/images/Machiato_Vanilla.png',
    color: Color(0xFFC3AA8E),
  ),
];