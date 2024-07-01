import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoritelist = provider.favorite;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const SizedBox(
                width: 110,
              ),
              const Text(
                "Favourite",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 110,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  minimumSize: const Size(44, 44),
                  backgroundColor: const Color(0xFF533A28),
                ),
                child: SvgPicture.asset("assets/vectors/Heart.svg"),
              ),
            ],
          ),
          SizedBox(
            height: 540,
              child: ListView.builder(
            itemCount: favoritelist.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final favoriteitems = favoritelist[index];
              return Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: 139,
                        width: 412,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white
                        ),
                        child: Row(
                          children: [
                            Text(favoriteitems["name"]),
                            Image.asset(urlimg + favoriteitems["img"])
                          ],
                        ),
                      ))
                ],
              );
            },
          )),
          Image.asset("assets/images/FavoritePic.png"),
        ],
      ),
    );
  }
}
