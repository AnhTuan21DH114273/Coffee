import 'dart:math';

import 'package:flutter/material.dart';
import '../data/model/product.dart';

class MyFoodScreen extends StatefulWidget {
  const MyFoodScreen({super.key});

  @override
  State<MyFoodScreen> createState() => _MyFoodScreenState();
}

class _MyFoodScreenState extends State<MyFoodScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  List<FoodModel> _foodlist = foodList;

  double get _currentOffset {
    bool inited = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return inited ? _pageController.page! : _pageController.initialPage * 1.0;
  }

  int get _currentIndex => _currentOffset.round() % _foodlist.length;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _foodlist.length * 9999,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.maxFinite,
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
          return _buildScreen();
        },
        ),
      )
    );
  }

  Container _buildScreen() {
    final Size size = MediaQuery.of(context).size;
    final FoodModel _currentFood = _foodlist[_currentIndex];
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE3E3E3), 
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
          child: Container(
            alignment: Alignment.topCenter,
            height: 240,
            decoration: const BoxDecoration(
              color: Color(0xFFCFB07A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(250), bottomRight: Radius.circular(250))
              ),
          )
        ),
        Positioned(
          child: Container(
            height: 350,
          )
        ),
        const Positioned(
          top: 50,
          child: Text(
            "DETAILS",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        Positioned(
          top: 130,
          child: SizedBox(
            height: 400,
            width: 500,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                double _value = 0.0;
                double vp = 1;
                double scale = max(vp, (_currentOffset - index).abs());

                if (_pageController.position.haveDimensions) {
                  _value = index.toDouble() - (_pageController.page ?? 0);
                  _value = (_value * 0.7).clamp(-1, 1);
                }
                return Transform.rotate(
                    angle: -0.4 * _value,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 200 - scale * 5),
                      child: FittedBox(
                        child: Image.asset(
                          _foodlist[index % _foodlist.length].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
        ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 110),
          child:SizedBox(
            width: 300,
            child: Text(
              _currentFood.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),),
        const Padding(
          padding: EdgeInsets.only(right: 380),
          child:Text(
              "Cold",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
        ),
        ),
        Container(
              margin: const EdgeInsets.only(left: 9.0, right: 9.0),
              child: const Divider(
                color: Colors.black,
                height: 30,
            )),
        const Padding(
          padding: EdgeInsets.only(right: 270),
          child:Text(
              "Description",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 100, left: 17),
          child: SizedBox(
          width: 327,
          child: Text(
              _currentFood.desc,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 350),
          child:Text(
              "Size",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 10,),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle (
                  padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)) ,
                  minimumSize: WidgetStateProperty.all<Size>(const Size(96, 41)) ,
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey)
                  ))
                ),
                child: const Text(
                "S",
                style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.7,
                color: Color(0xFF000000),
              ),),
            ),
            const SizedBox(width: 10,),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle (
                  padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)) ,
                  minimumSize: WidgetStateProperty.all<Size>(const Size(96, 41)) ,
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey)
                  ))
                ),
                child: const Text(
                "M",
                style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.7,
                color: Color(0xFF000000),
              ),),
            ),
            const SizedBox(width: 10,),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle (
                  padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)) ,
                  minimumSize: WidgetStateProperty.all<Size>(const Size(96, 41)) ,
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey)
                  ))
                ),
                child: const Text(
                "L",
                style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.7,
                color: Color(0xFF000000),
              ),),
            ),
          ],
        )
        ],
      ),
    );
  }
}


/*Positioned(
          left: 20,
          top: 270,
          child: Text(
              _currentFood.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 300,
          child: Text(
              "Cold",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 320,
          child: Text(
              "Description",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 350,
          child: SizedBox(
            width: 327,
            child: Text(
              _currentFood.desc,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
            ),
            ),
          )
        )*/


/*Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
          child: Image.asset("assets/images/Details_Circle.png")
        ),
        const Positioned(
          top: 20,
          child: Text(
            "DETAILS",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        Positioned(
          top: 150,
          child: SizedBox(
            height: 400,
            width: 500,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                double _value = 0.0;
                double vp = 1;
                double scale = max(vp, (_currentOffset - index).abs());

                if (_pageController.position.haveDimensions) {
                  _value = index.toDouble() - (_pageController.page ?? 0);
                  _value = (_value * 0.7).clamp(-1, 1);
                }
                return Transform.rotate(
                    angle: pi * _value,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 200 - scale * 5),
                      child: FittedBox(
                        child: Image.asset(
                          _foodlist[index % _foodlist.length].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
        ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 200),
          child:Text(
              _currentFood.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 380),
          child:Text(
              "Cold",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
        ),
        ),
        Container(
              margin: const EdgeInsets.only(left: 9.0, right: 9.0),
              child: const Divider(
                color: Colors.black,
                height: 30,
            )),
        const Padding(
          padding: EdgeInsets.only(right: 270),
          child:Text(
              "Description",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 327,
          child: Text(
              _currentFood.desc,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );*/