import 'package:app_coffee/data/model/shop.dart';
import 'package:app_coffee/order/pickup_details.dart';
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
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickupDetails(
                            shopId: lists.id,
                          ),
                        ),
                      );
                    },
                    child: Image.asset("assets/images/shopList.png",
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                  const SizedBox(width: 40,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "BEAR'S COFFEE",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      Text(
                        lists.name,
                        style: const TextStyle(
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