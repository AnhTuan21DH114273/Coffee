import 'package:app_coffee/home/home.dart';
import 'package:app_coffee/page/sign_in_or_sign_up.dart';
import 'package:app_coffee/signIn/forgotPass.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/config/config_manager.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFC3916B),
        ),
        width: double.maxFinite,
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 80, left: 0),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInOrSignUp()));
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                            minimumSize: const Size(0, 0),
                            backgroundColor: const Color(0xFFC3916B),
                            side: BorderSide.none,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      width: 160,
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Username",
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Mật khẩu",
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 36),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        print('Sending login request...');
                        final response = await http.post(
                          Uri.parse('$baseURL/api/auth/signin'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'name': nameController.text,
                            'password': passwordController.text,
                          }),
                        );

                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        if (response.statusCode == 200) {
                          final responseData = jsonDecode(response.body);
                          final userData = responseData['user'];
                          print('User data: $userData'); // Log user data

                          if (userData != null && userData['name'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Welcome ${userData['name']}")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "User data is missing or malformed")),
                            );
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${response.body}")),
                          );
                        }
                      } catch (e) {
                        print('Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      minimumSize: const Size(400, 10),
                      backgroundColor: const Color(0xFFFFBE98),
                    ),
                    child: const Text(
                      "TIếp tục",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.7,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Có quên mật khẩu?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpass()));
                    }, 
                    child: const Text("Tìm mật khẩu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),),
                    )
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 16,
                        )),
                  ),
                  const Text("Or"),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 16,
                        )),
                  ),
                ]),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.facebook,
                      color: Color.fromRGBO(105, 155, 247, 1),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      minimumSize: const Size(400, 10),
                      backgroundColor: const Color.fromRGBO(0, 82, 180, 1),
                    ),
                    label: const Text(
                      "Facebook",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.7,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.mail,
                        color: Color.fromRGBO(228, 133, 133, 1)),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      minimumSize: const Size(400, 10),
                      backgroundColor: const Color.fromRGBO(238, 69, 69, 1),
                    ),
                    label: const Text(
                      "Gmail",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.7,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 267,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    textAlign: TextAlign.center,
                    "By sign in or sign up, you agree to our Terms of Service and Privacy Policy",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.7,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
