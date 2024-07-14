import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String selectedLanguage = 'Tiếng Việt';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 35,
        ),
        const Text(
          "CHỌN NGÔN NGỮ",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Text(
          "Bạn muốn sử dụng ngôn ngữ nào?",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 57,
            ),
            SvgPicture.asset("assets/vectors/USA_Flag.svg"),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Tiếng Anh",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFBE98),
              ),
            ),
            const SizedBox(
              width: 180,
            ),
            Transform.scale(
            scale: 1.5,
            child:Radio<String>(
              value: "Tiếng Anh", 
              groupValue: selectedLanguage,
              onChanged: (selectedValue){
                setState(() => selectedLanguage = selectedValue!);
              },
              activeColor: const Color(0xFFFFBE98), 
              fillColor: const WidgetStatePropertyAll(Color(0xFFFFBE98)),
              
            ))
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 60.0, right: 60.0),
            child: const Divider(
              color: Colors.white,
              height: 30,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 57,
            ),
            SvgPicture.asset("assets/vectors/VN_Flag.svg"),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Tiếng Việt",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFBE98),
              ),
            ),
            const SizedBox(
              width: 180,
            ),
            Transform.scale(
            scale: 1.5,
            child: Radio<String>(
              value: "Tiếng Việt", 
              groupValue: selectedLanguage,
              onChanged: (selectedValue){
                setState(() => selectedLanguage = selectedValue!);
              },
              activeColor: const Color(0xFFFFBE98), 
              fillColor: const WidgetStatePropertyAll(Color(0xFFFFBE98)),
            ),)
          ],
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 140,
          padding: const EdgeInsets.only(bottom: 0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              minimumSize: const Size(400, 10),
              backgroundColor: const Color(0xFFFFBE98),
            ),
            child: const Text(
              "USE",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                height: 1.7,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
