import 'package:app_coffee/congf/const.dart';
import 'package:app_coffee/data/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 139,
                        width: 412,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white
                        ),
                        child: Row(
                          children: [
                            Image.asset(urlimg + favoriteitems["img"]),
                            const SizedBox(width: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: Text(favoriteitems["name"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: Text(favoriteitems["des"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: Text(NumberFormat("##,###.### VND").format(favoriteitems["price"]),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),),
                                ),
                              ],
                            )
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
