import 'package:app_coffee/signIn/signIn.dart';
import 'package:flutter/material.dart';

class Confirmpass extends StatefulWidget {
  const Confirmpass({super.key});

  @override
  State<Confirmpass> createState() => _ConfirmpassState();
}

class _ConfirmpassState extends State<Confirmpass> {
  final passController = TextEditingController();
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC3916B),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 90,
                ),
                Text(
                  "Nhập lại mật khẩu",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 230,
            ),
            SizedBox(width: 400,
            child: TextFormField(
              controller: passController,
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
                  labelText: "Tạo mật khẩu mới",
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
            ),),
            SizedBox(width: 400,
            child: TextFormField(
              controller: passController,
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
                  labelText: "Nhập lần 2 Mật khẩu",
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
            ),),
            const SizedBox(
              height: 250,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInWidget()));
              },
              style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(12)),
                  minimumSize:
                      WidgetStateProperty.all<Size>(const Size(400, 11)),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFFC67C4E)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.grey)))),
              child: const Text(
                "Tiếp tục",
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
      ),
    );
  }
}
