import 'package:app_coffee/congf/const.dart';
import 'package:flutter/material.dart';
import '../../data/model/product.dart';
import '../../data/service/product_service.dart';

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
  final TextEditingController catIdController = TextEditingController();
  final TextEditingController colorController =
      TextEditingController(); // Thêm controller cho màu

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    desController.dispose();
    descController.dispose();
    priceController.dispose();
    imgController.dispose();
    catIdController.dispose();
    colorController.dispose(); // Dispose controller màu
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
                tec: colorController, // Thêm trường màu
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
                    // Xử lý thêm sản phẩm
                    addProduct();
                  },
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

  Future<void> addProduct() async {
    // Lấy dữ liệu từ các controller
    final name = nameController.text;
    final des = desController.text;
    final desc = descController.text;
    final price = double.tryParse(priceController.text) ?? 0;
    final image = imgController.text;
    final catId = int.tryParse(catIdController.text) ?? 0;
    final color = colorController.text; // Lấy dữ liệu màu

    // Tạo đối tượng ProductModel
    final product = ProductModel(
      id: 0, // ID sẽ được gán bởi API
      name: name,
      des: des,
      desc: desc,
      price: price,
      img: image,
      catId: catId,
      color: color,
    );

    try {
      // Gọi phương thức addProduct của ProductService
      final productService = ProductService();
      await productService.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sản phẩm đã được thêm thành công')),
      );
      Navigator.pop(context); // Quay lại trang trước đó
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thêm sản phẩm thất bại: $e')),
      );
    }
  }
}
