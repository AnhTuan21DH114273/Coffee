import 'package:app_coffee/congf/const.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imgController = TextEditingController();
  final TextEditingController catIdController =TextEditingController();
  final TextEditingController catNameController =TextEditingController();
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
        title: const Text('Thêm sản phẩm mới'),
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
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.amber),
                    foregroundColor:
                        WidgetStatePropertyAll<Color>(Colors.black),
                  ),
                  child: const Text('Thêm sản phẩm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}