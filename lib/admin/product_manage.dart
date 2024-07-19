import 'dart:convert';
import 'package:app_coffee/admin/product/addProduct.dart';
import 'package:app_coffee/admin/product/editProduct.dart';
import 'package:app_coffee/congf/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ProductManage extends StatefulWidget {
  const ProductManage({super.key});

  @override
  State<ProductManage> createState() => _ProductManageState();
}

class _ProductManageState extends State<ProductManage> {
  List<dynamic> products = [];
  Future<void> getProdbyId() async {
    try {
      final String response =
          await rootBundle.loadString("assets/files/product.json");
      final data = await json.decode(response);
      setState(() {
        products = data["data"];
      });
    } catch (e) {
      print(e);
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Addproduct()));
            },
            icon: const Icon(Icons.add, color: Colors.black,),
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Expanded(
            child: FutureBuilder(
              future: getProdbyId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return listView(product, context);
                  },
                );
              },
            ),
          )),
    );
  }

  Widget listView(product, BuildContext context) {
    return Container(
      width: 412,
      height: 92,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(urlimg + product["img"]),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 180,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text("Tên SP: ${product["name"]}"),
              Text("Mô tả: ${product["des"]}",
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
              Text("Giá: ${NumberFormat("##,###.### VNĐ").format(product["price"])}")
            ],
          ),
          ),
          const SizedBox(
            width: 25,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Editproduct(editproduct: product,)));
            },
            icon: const Icon(Icons.edit, color: Colors.yellow,),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.red,),
          ),
        ],
      ),
    );
  }
}
