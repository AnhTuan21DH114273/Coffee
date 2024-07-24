import 'package:app_coffee/order/map.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetail({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
        centerTitle: true,
        backgroundColor: Colors.white
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 412,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mã đơn hàng: ${order['id']}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ngày đặt hàng: ${order['order_date']}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 280,
                          child: Text(
                            'Địa chỉ: ${order['address']}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: 'Trạng thái: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: '${order['status']}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ))
                        ])),
                        const SizedBox(height: 8),
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
                    }, 
                    icon: Icon(Icons.arrow_forward_ios)
                    )
                  ],
                ),
              ),
              const Text('Sản phẩm:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7F4C2A))),
              Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 30,
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: (order['items'] as List).length,
                  itemBuilder: (context, index) {
                    final item = order['items'][index];
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(8),
                      width: 411,
                      height: 86,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, offset: Offset(0, 4))
                          ]),
                      child: ListTile(
                          title: Text(
                            item['product_name'],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ), // Correct field name
                          subtitle: Text(
                            '${item['product_description']} x ${item['quantity']}',
                            style: const TextStyle(
                                color: Color(0xFFA2A2A2),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          trailing: RichText(
                              text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text: 'Giá: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            TextSpan(
                                text: NumberFormat('###,###.### VND').format(item['price']),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ))
                          ]))),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
