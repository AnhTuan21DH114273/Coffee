class Category{
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

  Category.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    des = json['des'];
    catName = json['catName'];
  }

  Map<String,dynamic> toJson(){
    final
    Map<String,dynamic> data = <String,dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    data['des'] = des;
    data['catName'] = catName;
    return data;
  }
}