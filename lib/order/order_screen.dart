import 'package:app_coffee/order/delivery_screen.dart';
import 'package:app_coffee/order/pickup_screen.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade300),
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
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(
                  width: 110,
                ),
                const Text(
                  "Đơn hàng",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    minimumSize: const Size(44, 44),
                    backgroundColor: const Color(0xFF533A28),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonsTabBar(
              backgroundColor: const Color(0xFFC67C4E),
              unselectedBackgroundColor: const Color(0xFFEDEDED),
              controller: tabController,
              contentPadding: const EdgeInsets.symmetric(horizontal: 60),
              buttonMargin: const EdgeInsets.only(right: 15, left: 15),
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              tabs: const [
                Tab(
                  text: "Giao hàng",
                ),
                Tab(
                  text: "Đến lấy",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [const DeliveryScreen(), const PickupScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
