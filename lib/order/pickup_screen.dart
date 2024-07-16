import 'package:app_coffee/data/model/shop.dart';
import 'package:flutter/material.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final List<Shop> _list = shopList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300
        ),
        child: Expanded(
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            final Shop lists = _list[index];
            return Container(
              width: 412,
              height: 139,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset("assets/images/shopList.png"),
                  SizedBox(width: 40,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BEAR'S COFFEE",
                        style: TextStyle(
                          color: Color(0xFFCFCECE)
                        ),
                      ),
                      Text(
                        lists.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        )
        ),
      )
    );
  }
}