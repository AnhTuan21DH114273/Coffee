import 'package:flutter/material.dart';
import '../data/service/user_service.dart';
import '../data/model/user.dart';

class UserManager extends StatefulWidget {
  const UserManager({super.key});

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  List<UserModel> users = [];
  final UserService _userService = UserService(); // Initialize UserService

  @override
  void initState() {
    super.initState();
    getUsers(); // Fetch users when the widget is initialized
  }

  Future<void> getUsers() async {
    try {
      final userList = await _userService.fetchAllUsers();
      setState(() {
        users = userList;
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý người dùng"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: users.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return listView(user, context);
                },
              ),
      ),
    );
  }

  Widget listView(UserModel user, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tên: ${user.name}",
                  style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
                ),
                Text(
                  "Điện thoại: ${user.phone}",
                  style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              _showDeleteConfirmation(user.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa người dùng này?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                try {
                  await _userService.deleteUser(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Người dùng đã được xóa')),
                  );
                  getUsers(); // Refresh the list
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Xóa người dùng thất bại: $e')),
                  );
                }
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}
