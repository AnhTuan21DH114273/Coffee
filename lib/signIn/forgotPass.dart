import 'package:app_coffee/signUp/OTP.dart';
import 'package:flutter/material.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC3916B),
        ),
        width: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  "Quên mật khẩu",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                "Nhập số điện thoại để lấy lại mật khẩu bằng cách gửi mã OTP",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Điện thoại",
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
            ),
            ),
            SizedBox(height: 300,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => OTPWidget(phoneNumber: phoneController.text,)));
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
