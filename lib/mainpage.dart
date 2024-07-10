import 'package:flutter/material.dart';
import 'home/home.dart';
import 'home/voucher.dart';
import 'home/cart.dart';
import 'home/user.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Voucher(),
    Cart(),
    User()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      drawer: Drawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '___',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell_outlined),
              label: '___',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: '___',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: '___',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFA67B5B),
          onTap: _onItemTapped,
        ),
        )
          
      ),
    );
  }
}
