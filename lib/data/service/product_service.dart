import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';
import '../config/config_manager.dart';

class ProductService {
  // URL API từ config
  final String baseUrl = '$baseURL/api/products';

  // Phương thức fetchProducts để lấy danh sách sản phẩm từ API
  Future<List<ProductModel>> fetchProducts() async {
    try {
      // Gửi yêu cầu GET tới API
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // Giải mã JSON và chuyển đổi thành danh sách ProductModel
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        List<dynamic> jsonList = jsonMap['data']; // Trích xuất trường 'data'
        List<ProductModel> products =
            jsonList.map((e) => ProductModel.fromJson(e)).toList();
        return products;
      } else {
        // Ném ngoại lệ nếu không thành công
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi chi tiết hơn
      throw Exception('Failed to load products: $e');
    }
  }

  // Phương thức fetchProductById để lấy thông tin sản phẩm theo ID
  Future<ProductModel> fetchProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        // Giải mã JSON và chuyển đổi thành đối tượng ProductModel
        Map<String, dynamic> jsonMap = json.decode(response.body);
        return ProductModel.fromJson(jsonMap);
      } else {
        // Ném ngoại lệ nếu không thành công
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi chi tiết hơn
      throw Exception('Failed to load product: $e');
    }
  }
  // Phương thức fetchProductsByCategory để lấy danh sách sản phẩm theo category
  Future<List<ProductModel>> fetchProductsByCategory(int catId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/category/$catId'));

      if (response.statusCode == 200) {
        // Giải mã JSON và chuyển đổi thành danh sách ProductModel
        List<dynamic> jsonList = json.decode(response.body)['data'];
        List<ProductModel> products =
            jsonList.map((e) => ProductModel.fromJson(e)).toList();
        return products;
      } else {
        // Ném ngoại lệ nếu không thành công
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi chi tiết hơn
      throw Exception('Failed to load products: $e');
    }
  }
  Future<void> addProduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
  Future<void> updateProduct(ProductModel product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }
  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

}

