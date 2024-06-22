class FoodModel {
  String name;
  String desc;
  double price;
  String image;
  FoodModel({
    required this.name,
    required this.desc,
    required this.price,
    required this.image,
  });
}

List<FoodModel> foodList = [
  FoodModel(
    name: 'Machiato with Milk',
    desc: 'A Guava tea is fruit drinks with natural fruits, supplemented with Vitamin C are guaranteed to be good for the body. Read More',
    price: 60.000,
    image: 'assets/images/Machiato_Milk.png',
  ),
  FoodModel(
    name: 'Machiato',
    desc: 'A matcha cream is an approximately 120 ml (4 oz) beverage, with 20 ml of espresso coffee and 30ml of match milk the fo.. Read More',
    price: 60.000,
    image: 'assets/images/Machiato.png',
  ),
  FoodModel(
    name: 'Machiato with Vanilla',
    desc: 'A Latte milk is an approximately 120 ml (4 oz) beverage, with 15 ml of espresso coffee and 85ml of fresh milk the fo.. Read More',
    price: 60.009,
    image: 'assets/images/Machiato_Vanilla.png',
  ),
];