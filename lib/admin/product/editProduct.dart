import 'package:app_coffee/congf/const.dart';
import 'package:flutter/material.dart';

class Editproduct extends StatefulWidget {
  final dynamic editproduct;
  const Editproduct({super.key, this.editproduct});

  @override
  State<Editproduct> createState() => _EditproductState();
}

class _EditproductState extends State<Editproduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  TextEditingController catIdController =TextEditingController();
  TextEditingController catNameController =TextEditingController();
  @override
  void initState() {
    String prodName = widget.editproduct["name"];
    String prodDes = widget.editproduct["des"];
    String prodDesc = widget.editproduct["desc"];
    int prodPrice = widget.editproduct["price"];
    String prodImg = widget.editproduct["img"];
    int prodCatId = widget.editproduct["catId"];
    String prodCatName = widget.editproduct["catName"];

    nameController = TextEditingController(text: prodName);
    desController = TextEditingController(text: prodDes);
    descController = TextEditingController(text: prodDesc);
    priceController = TextEditingController(text: prodPrice.toString());
    imgController = TextEditingController(text: prodImg);
    catIdController = TextEditingController(text: prodCatId.toString());
    catNameController = TextEditingController(text: prodCatName);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    desController.dispose();
    descController.dispose();
    priceController.dispose();
    imgController.dispose();
    catIdController.dispose();
    catNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa sản phẩm'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldWidget(
                tec: nameController,
                label: 'Tên Sản Phẩm',
                hint: '',
                icon: const Icon(Icons.abc),
              ),
              TextFieldWidget(
                tec: desController,
                label: 'Mô tả',
                hint: '',
                icon: const Icon(Icons.description),
              ),
              TextFieldWidget(
                tec: descController,
                label: 'Mô tả dài',
                hint: '',
                icon: const Icon(Icons.description),
              ),
              TextFieldWidget(
                tec: priceController,
                label: 'Giá',
                hint: '',
                icon: const Icon(Icons.money),
              ),
              TextFieldWidget(
                tec: imgController,
                label: 'Hình Ảnh',
                hint: '',
                icon: const Icon(Icons.image),
              ),
              TextFieldWidget(
                tec: catIdController,
                label: 'Loại sản phẩm theo ID',
                hint: '',
                icon: const Icon(Icons.numbers),
              ),
              TextFieldWidget(
                tec: catNameController,
                label: 'Loại sản phẩm theo TÊN',
                hint: '',
                icon: const Icon(Icons.abc),
              ),
              Card.outlined(
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    urlimg + imgController.text,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.amber),
                    foregroundColor:
                        WidgetStatePropertyAll<Color>(Colors.black),
                  ),
                  child: const Text('Chỉnh Sửa'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}