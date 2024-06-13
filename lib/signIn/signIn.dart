import 'package:flutter/material.dart';

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
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top:40),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                    ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Full Name",
                    icon: Icon(Icons.person,color: Colors.black,),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ) 
                    
                  ),
                ),
                const SizedBox(height:40),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Password",
                    icon: Icon(Icons.lock, color: Colors.black,),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )  
                  ),
                ),
                const SizedBox(height: 36),
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
                const SizedBox(height: 120,),
                Row(
                  children:[
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
                  icon: const Icon(Icons.facebook,color: Color.fromRGBO(105, 155, 247, 1),),
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
                  ),),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 80,
                padding: const EdgeInsets.only(bottom: 0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.mail,color: Color.fromRGBO(228, 133, 133, 1)),
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
                  ),),
                ),
              ),
              const SizedBox(height: 70,),
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