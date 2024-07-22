// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:app_coffee/mainpage.dart';
import 'package:app_coffee/order/view_order.dart';
import 'package:app_coffee/signIn/signIn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/config/config_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();
  final addressController = TextEditingController();
  String? userId;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchData(); // Lấy dữ liệu người dùng khi khởi tạo state
  }

  Future<void> _loadUserIdAndFetchData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    if (userId != null) {
      await _fetchUserData();
    } else {
      // Handle the case where userId is not set or is null
      print("No user ID found in SharedPreferences.");
    }
  }

  Future<void> _fetchUserData() async {
    if (userId == null) {
      print("User ID is not set.");
      return;
    }

    try {
      final response = await http.get(Uri.parse('$baseURL/api/user/$userId'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Extract the list of users
        final List<dynamic> users = responseData['user'];

        if (users.isNotEmpty) {
          // Get the first user in the list
          final userData = users[0]; // This is a map with user details

          // Update the controllers with the user data
          setState(() {
            nameController.text = userData['name'] ?? '';
            phoneController.text = userData['phone'] ?? '';
            mailController.text =
                userData['email'] ?? ''; // Update with email if available
            addressController.text =
                userData['address'] ?? ''; // Update with address if available
          });
        } else {
          print("No user data available.");
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveUserData() async {
    if (userId == null) {
      print("User ID is not set.");
      return;
    }

    final updatedUserData = {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': mailController.text,
      'address': addressController.text,
    };

    try {
      final response = await http.put(
        Uri.parse('$baseURL/api/user/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedUserData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Thông tin đã được cập nhật"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cập nhật thông tin không thành công"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Hiển thị hộp thoại xác nhận
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có muốn đăng xuất không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                await prefs.remove('userId');
                Navigator.of(context).pop(); // Đóng hộp thoại
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInWidget()),
                );
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    if (userId == null) {
      print("User ID is not set.");
      return;
    }

    try {
      final response =
          await http.delete(Uri.parse('$baseURL/api/user/$userId'));

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('userId');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Xoá tài khoản thành công"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInWidget()),
        );
      } else {
        throw Exception('Failed to delete account');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Xoá tài khoản không thành công"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Mainpage()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 120),
                    const Text(
                      "Tài khoản",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage("assets/images/avatar.png"),
                  radius: 55,
                  onBackgroundImageError: (exception, stackTrace) {
                    const Text("Nothing");
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  width: 400,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Xem đơn hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewOrder(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: mailController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _saveUserData, // Add this function
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(12),
                    ),
                    minimumSize:
                        WidgetStateProperty.all<Size>(const Size(400, 11)),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.green),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Lưu thông tin",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                  onPressed: _logout,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(12),
                    ),
                    minimumSize:
                        WidgetStateProperty.all<Size>(const Size(180, 11)),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFFC67C4E)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Đăng xuất",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: _deleteAccount,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(12),
                    ),
                    minimumSize:
                        WidgetStateProperty.all<Size>(const Size(180, 11)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                       const Color(0xFFC67C4E)), // Màu đỏ cho nút xoá tài khoản
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Xoá tài khoản",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ),
                  ],
                ),
                Image.asset("assets/images/FavoritePic.png"),
              ],
            ),
          ),
        ));
  }
}
