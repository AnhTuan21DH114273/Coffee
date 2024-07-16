class Category {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;
  String? catName;

  Category({
    this.id,
    this.name,
    this.price,
    this.img,
    this.des,
    this.catId,
    this.catName,
  });

  // Factory constructor to create a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      des: json['des'],
      catId: json['catId'],
      catName: json['catName'],
    );
  }

  // Method to convert a Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'des': des,
      'catId': catId,
      'catName': catName,
    };
  }
}
