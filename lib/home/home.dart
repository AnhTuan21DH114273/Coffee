import 'package:app_coffee/category/categorywidget.dart';
import 'package:app_coffee/home/favorite.dart';
import 'package:app_coffee/screen/slider.dart';
import 'package:app_coffee/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/model/location.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      key: scaffoldState,
      drawer: const SizedBox(
        width: 225,
        child: Sidebar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 171,
                decoration: const BoxDecoration(
                  color: Color(0xFFC3916B),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            scaffoldState.currentState?.openDrawer();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(14),
                            minimumSize: const Size(44, 44),
                            backgroundColor: const Color(0xFF533A28),
                          ),
                          child: SvgPicture.asset("assets/vectors/Sidebar.svg"),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 230,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                hint: const Text("Chọn Quận",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                                value: valChoose,
                                items: lstLocation.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    valChoose = value!;
                                  });
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Favorite()));
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
                    Container(
                      height: 56,
                      width: 412,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: CupertinoSearchTextField(
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                        controller: textController,
                        placeholder: 'Tìm kiếm cà phê,...',
                        placeholderStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: const Color(0xFF714E35),
                        suffixIcon: const Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: SliderP(),
              ),
              const Expanded(child: CategoryWidget()),
            ],
          )),
    );
  }
}
