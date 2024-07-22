import 'package:flutter/material.dart';
import 'package:app_coffee/congf/const.dart';
import '../../data/model/product.dart';
import '../../data/service/product_service.dart';

class Editproduct extends StatefulWidget {
  final ProductModel editproduct;
  const Editproduct({super.key, required this.editproduct});

  @override
  State<Editproduct> createState() => _EditproductState();
}

class _EditproductState extends State<Editproduct> {
  late TextEditingController nameController;
  late TextEditingController desController;
  late TextEditingController descController;
  late TextEditingController priceController;
  late TextEditingController imgController;
  late TextEditingController catIdController;
  late TextEditingController colorController; // Controller for color

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing product data
    final product = widget.editproduct;
    nameController = TextEditingController(text: product.name);
    desController = TextEditingController(text: product.des);
    descController = TextEditingController(text: product.desc);
    priceController = TextEditingController(text: product.price.toString());
    imgController = TextEditingController(text: product.img);
    catIdController = TextEditingController(text: product.catId.toString());
    colorController = TextEditingController(
        text: product.color); // Initialize color controller
  }

  @override
  void dispose() {
    nameController.dispose();
    desController.dispose();
    descController.dispose();
    priceController.dispose();
    imgController.dispose();
    catIdController.dispose();
    colorController.dispose();
    super.dispose();
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
                tec: colorController, // Added color field
                label: 'Màu sắc',
                hint: '',
                icon: const Icon(Icons.color_lens),
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
                    updateProduct();
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.amber),
                    foregroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                  child: const Text('Chỉnh sửa'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct() async {
    final name = nameController.text;
    final des = desController.text;
    final desc = descController.text;
    final price = double.tryParse(priceController.text) ?? 0;
    final img = imgController.text;
    final catId = int.tryParse(catIdController.text) ?? 0;
    final color = colorController.text;

    final updatedProduct = ProductModel(
      id: widget.editproduct.id, // Use existing product ID
      name: name,
      des: des,
      desc: desc,
      price: price,
      img: img,
      catId: catId,
      color: color,
    );

    try {
      final productService = ProductService();
      await productService.updateProduct(updatedProduct);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sản phẩm đã được cập nhật thành công')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật sản phẩm thất bại: $e')),
      );
    }
  }
}
