import 'package:app_coffee/mainpage.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFC3916B),
      child: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Image.asset("assets/images/Drawer.png"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Trang Chủ"),
            onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Mainpage()));
            },
          ),
          const ListTile(
            leading: Icon(Icons.coffee),
            title: Text("Cà phê"),
          ),
          const ListTile(
            leading: SizedBox(width: 10,),
            title: Text("| Cappuchino"),
          ),
          const ListTile(
            leading: SizedBox(width: 10,),
            title: Text("| Machiato"),
          ),
          const ListTile(
            leading: SizedBox(width: 10,),
            title: Text("| Latte"),
          ),
          const ListTile(
            leading: Icon(Icons.coffee_outlined),
            title: Text("Trà"),
          ),
          const ListTile(
            leading: SizedBox(width: 10,),
            title: Text("| Matcha"),
          ),
          const ListTile(
            leading: SizedBox(width: 10,),
            title: Text("| Fruit Tea"),
          ),
          const ListTile(
            leading: SizedBox(width: 10,),
            title: Text("| Latte"),
          ),
          Image.asset("assets/images/DrawerBottom.png")
        ],
      )
    );
  }
}