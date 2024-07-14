import 'package:app_coffee/mainpage.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final mailController = TextEditingController();
    final addressController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Container(
          color: Colors.grey.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  const Text(
                    "Tài khoản",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ),
              SizedBox(height: 30,),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/user.png"),
                radius: 55,
                onBackgroundImageError: (exception, stackTrace) {
                 Text("Nothing");
              },),
              SizedBox(height: 30,),
              TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.update,
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
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.update,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: mailController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      icon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.update,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.update,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Mainpage()));
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
                Image.asset("assets/images/FavoritePic.png")
            ]
          )
      )
    );
  }
}