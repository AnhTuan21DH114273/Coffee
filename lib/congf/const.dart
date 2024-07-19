import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const urlimg = "assets/images/";
const url_product_img = "assets/images/products/";
const titleStyle = TextStyle(
  fontSize: 32,
  color: Color.fromARGB(255, 11, 7, 233),
  );
const colorBackground = Color.fromRGBO(108, 117, 125, 0);

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.tec,
    required this.label,
    required this.hint,
    required this.icon,
  });

  final TextEditingController tec;
  final String label;
  final String hint;
  final Icon icon;

  @override
  State<StatefulWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: TextFormField(
        controller: widget.tec,
        obscureText: widget.label.toLowerCase().contains('password'),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          labelText: widget.label,
          hintText: widget.hint,
          icon: widget.icon,
        ),
        onChanged: (_) => setState(() {}),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please type something';
          }
          return null;
        },
      ),
    );
  }
}