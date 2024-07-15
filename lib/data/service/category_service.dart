import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/category.dart'; 
import '../config/config_manager.dart';

class CategoryService {
  final String apiUrl = '$baseURL/api/categories';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => Category.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load categories from API');
    }
  }

  Future<Category> fetchCategoryById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return Category.fromJson(json.decode(response.body)['data'][0]);
    } else {
      throw Exception('Failed to load category from API');
    }
  }
}
