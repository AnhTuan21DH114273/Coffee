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
      backgroundColor: const Color(0xFFF9F9F9),
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
                    icon: const Icon(Icons.arrow_back),
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
              const SizedBox(height: 30,),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage("assets/images/user.png"),
                radius: 55,
                onBackgroundImageError: (exception, stackTrace) {
                 const Text("Nothing");
              },),
              const SizedBox(height: 12,),
              Container(
                width: 400,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black))
                ),
                child: Row(
                  children: [
                    const Text(
                      "View Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 270,),
                    IconButton(onPressed: (){

                    }, 
                    icon: const Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
              SizedBox(
                width: 400,
                child:TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
                      )),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 400,
                child:TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
                      )),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 400,
                child:TextFormField(
                  controller: mailController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
                      )),
                ),
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: 400,
                child:TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
                      )),
                ),
              ),
              const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Mainpage()));
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