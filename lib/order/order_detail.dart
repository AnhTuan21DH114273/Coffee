import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetail({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ID: ${order['id']}'),
        backgroundColor: const Color(0xFFC67C4E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Date: ${order['order_date']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Address: ${order['address']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Payment Method: ${order['payment_method']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Status: ${order['status']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Total Price: ${order['total_price']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Delivery Fee: ${order['delivery_fee']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Total Amount: ${order['total_amount']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: (order['items'] as List).length,
                itemBuilder: (context, index) {
                  final item = order['items'][index];
                  return ListTile(
                    title: Text(item['product_name']), // Correct field name
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Text('Price: ${item['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
