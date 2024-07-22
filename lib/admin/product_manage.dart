import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_coffee/admin/product/addProduct.dart';
import 'package:app_coffee/admin/product/editProduct.dart';
import 'package:app_coffee/congf/const.dart';
import '../data/service/product_service.dart';
import '../data/model/product.dart';

class ProductManage extends StatefulWidget {
  const ProductManage({super.key});

  @override
  State<ProductManage> createState() => _ProductManageState();
}

class _ProductManageState extends State<ProductManage> {
  List<ProductModel> products = [];
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    getProdbyId();
  }

  Future<void> getProdbyId() async {
    try {
      final productList = await _productService.fetchProducts();
      setState(() {
        products = productList;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await _productService.deleteProduct(productId);
      setState(() {
        products.removeWhere((product) => product.id == productId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sản phẩm đã được xoá thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xoá sản phẩm thất bại: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý sản phẩm"),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Addproduct()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: products.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return listView(product, context);
                },
              ),
      ),
    );
  }

  Widget listView(ProductModel product, BuildContext context) {
    return Container(
      width: 412,
      height: 92,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/${product.img}',
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text("Tên SP: ${product.name}"),
                Text(
                  "Mô tả: ${product.des}",
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                    "Giá: ${NumberFormat("##,###.### VNĐ").format(product.price)}")
              ],
            ),
          ),
          const SizedBox(width: 25),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Editproduct(
                            editproduct: product,
                          )));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.yellow,
            ),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(product.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xoá'),
          content: const Text('Bạn có chắc chắn muốn xoá sản phẩm này?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Huỷ'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
                deleteProduct(productId); // Gọi phương thức xoá sản phẩm
              },
              child: const Text('Xoá'),
            ),
          ],
        );
      },
    );
  }
}
