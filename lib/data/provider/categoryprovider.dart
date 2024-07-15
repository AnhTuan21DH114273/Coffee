import 'package:flutter/material.dart';
import '../model/category.dart';
import '../service/category_service.dart'; // Adjust the import to match your file structure

class CategoryProvider with ChangeNotifier {
  CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];
  bool _loading = false;

  List<Category> get categories => _categories;
  bool get loading => _loading;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    _loading = true;
    notifyListeners();

    _categories = await _categoryService.fetchCategories();

    _loading = false;
    notifyListeners();
  }
}
