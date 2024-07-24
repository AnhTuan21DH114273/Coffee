import 'dart:convert';

import 'package:app_coffee/data/config/config_manager.dart';
import 'package:app_coffee/order/review.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Deliverinfo extends StatefulWidget {
  const Deliverinfo({super.key});

  @override
  State<Deliverinfo> createState() => _DeliverinfoState();
}

class _DeliverinfoState extends State<Deliverinfo> {
  String selectedLanguage = 'Tiếng Việt';
  String? userId;
  String name = '';
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
            name = userData['name'] ?? '';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 5,
          width: 45,
          decoration: BoxDecoration(
              color: const Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(16)),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "15 phút",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(children: <TextSpan>[
          const TextSpan(
              text: 'Giao cho ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          TextSpan(
              text: name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ))
        ])),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF36C07E),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF36C07E),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF36C07E),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 71.25,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFE3E3E3),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: 412,
          height: 77,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE3E3E3)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE3E3E3)),
                      color: Colors.white),
                  child: Image.asset("assets/images/Motor.png")),
              const SizedBox(
                width: 10,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Đang giao đơn đặt hàng của bạn",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 243,
                    child: Text(
                      "Chúng tôi sẽ giao hàng cho bạn trong thời gian ngắn nhất.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: 412,
          height: 77,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE3E3E3)),
                      color: Colors.white),
                  child: Image.asset("assets/images/avatar.png")),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 243,
                    child: Text(
                      "Chuyển phát nhanh cá nhân",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 44,
                height: 44,
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFE3E3E3))),
                child: Icon(Icons.phone_outlined),
              ),
              Padding(padding: EdgeInsets.only(left: 10))
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Review()));
          },
          style: ButtonStyle(
              padding:
                  WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
              minimumSize: WidgetStateProperty.all<Size>(const Size(400, 11)),
              backgroundColor:
                  WidgetStateProperty.all<Color>(const Color(0xFFC67C4E)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.grey)))),
          child: const Text(
            "Đã nhận hàng",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
