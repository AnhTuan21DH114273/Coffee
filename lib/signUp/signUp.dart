import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    const Icon(Icons.arrow_back),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Text(
                        'Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                        ),
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Họ và tên",
                    icon: Icon(Icons.person,color: Colors.black,),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ) 
                    
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Số điện thoại",
                    icon: Icon(Icons.person,color: Colors.black,),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ) 
                    
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: hidden,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      padding: const EdgeInsetsDirectional.only(end: 12),
                      icon: hidden? const Icon(Icons.visibility_off,) : const Icon(Icons.visibility,),
                      onPressed: (){
                        setState(() {
                          hidden =! hidden;
                        });
                      },
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Mật khẩu",
                    icon: const Icon(Icons.lock, color: Colors.black,),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )  
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmpassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Nhập lại mật khẩu",
                    icon: Icon(Icons.lock, color: Colors.black,),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )  
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ElevatedButton(
                    onPressed: () {},
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
                    ),),
                  ),
                ),
                const SizedBox(height: 16,),
                SvgPicture.asset("assets/vectors/CoffeeM.svg"),
                const SizedBox(height: 25,),
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