import 'package:app_coffee/screen/deliverInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  
  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  void _showModalBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (context) => const SingleChildScrollView(
        child: Deliverinfo(),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset("assets/images/Map.png")
          ),
          Positioned(
            top: 15,
            left: 0,
            child: IconButton(onPressed: (){},
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            ),
          ),
          Positioned(
            top: 15,
            right: 5,
            child: ElevatedButton(
              onPressed: () => _showModalBottomSheet(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14),
                minimumSize: const Size(44, 44),
                backgroundColor: const Color(0xFF533A28),
              ),
              child: SvgPicture.asset("assets/vectors/gps.svg"),
            ),
          ),
          const Positioned(
            bottom: 180,
            left: 0,
            right: 0,
            child: Text("Click the Icon to see the info",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            ),
          )
        ],
      ),
    );
  }
}