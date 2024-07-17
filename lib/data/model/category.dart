class Category {
  int? id;
  String? name;
  

  Category({
    this.id,
    this.name,
    
  });

  // Factory constructor to create a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      
    );
  }

  // Method to convert a Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
