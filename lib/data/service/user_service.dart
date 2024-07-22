import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart'; // Ensure this model matches the new schema
import '../config/config_manager.dart';

class UserService {
  final String baseUrl =
      '$baseURL/api/user'; // Ensure this path matches your API route

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<UserModel> fetchUser(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': user.name,
          'phone': user.phone,
          
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
