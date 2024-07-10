import 'package:app_coffee/page/sign_in_or_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'OTP.dart';
import '../data/config/config_manager.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});
  @override
  State<SignUpWidget> createState() => _SignUpWidgetWidgetState();
}

class _SignUpWidgetWidgetState extends State<SignUpWidget> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  bool hidden = true;

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
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 100),
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInOrSignUp()));
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(1),
                              minimumSize: const Size(0, 0),
                              backgroundColor: const Color(0xFFC3916B),
                              side: BorderSide.none,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 21,
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 6),
                      child: const Text(
                        'Sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
                    const SizedBox(
                      width: 140,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Họ và tên",
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Số điện thoại",
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: hidden,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        icon: hidden
                            ? const Icon(
                                Icons.visibility_off,
                              )
                            : const Icon(
                                Icons.visibility,
                              ),
                        onPressed: () {
                          setState(() {
                            hidden = !hidden;
                          });
                        },
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Mật khẩu",
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmpassController,
                  obscureText: hidden,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        icon: hidden
                            ? const Icon(
                                Icons.visibility_off,
                              )
                            : const Icon(
                                Icons.visibility,
                              ),
                        onPressed: () {
                          setState(() {
                            hidden = !hidden;
                          });
                        },
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Nhập lại mật khẩu",
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 25),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (passwordController.text !=
                          confirmpassController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Passwords do not match")),
                        );
                        return;
                      }

                      try {
                        print('Sending signup request...');
                        final response = await http.post(
                          Uri.parse(
                              '$baseURL/api/auth/signup'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'name': nameController.text,
                            'phone': phoneController.text,
                            'password': passwordController.text,
                          }),
                        );

                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        if (response.statusCode == 200) {
                          print('Sending OTP request...');
                          final otpResponse = await http.post(
                            Uri.parse('$baseURL/api/send-otp'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'phoneNumber': phoneController.text,
                            }),
                          );

                          print(
                              'OTP Response status: ${otpResponse.statusCode}');
                          print('OTP Response body: ${otpResponse.body}');

                          if (otpResponse.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPWidget(
                                    phoneNumber: phoneController.text),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Error: ${otpResponse.body}")),
                            );
                          }
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
                      "CONTINUE",
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
                  height: 16,
                ),
                SvgPicture.asset("assets/vectors/CoffeeM.svg"),
                const SizedBox(
                  height: 25,
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
                      color: Colors.black,
                      height: 1.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
