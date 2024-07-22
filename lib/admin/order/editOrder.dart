import 'package:flutter/material.dart';
import '../../data/model/order.dart';
import '../../data/service/order_service.dart';

class EditOrder extends StatefulWidget {
  final OrderModel? order;

  const EditOrder({super.key, this.order});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _deliveryFeeController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _paymentMethodController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final OrderService _orderService = OrderService(); // Initialize OrderService

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _addressController.text = widget.order!.address;
      _totalPriceController.text = widget.order!.totalPrice.toString();
      _deliveryFeeController.text = widget.order!.deliveryFee.toString();
      _totalAmountController.text = widget.order!.totalAmount.toString();
      _paymentMethodController.text = widget.order!.paymentMethod;
      _statusController.text = widget.order!.status;
      _notesController.text = widget.order!.notes ?? '';
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _totalPriceController.dispose();
    _deliveryFeeController.dispose();
    _totalAmountController.dispose();
    _paymentMethodController.dispose();
    _statusController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _updateOrder() async {
    if (widget.order == null) return;

    final updatedOrder = OrderModel(
      id: widget.order!.id,
      userId: widget.order!.userId, // Assuming userId should be preserved
      address: _addressController.text,
      orderDate: widget.order!.orderDate, // Preserving original date
      totalPrice: double.parse(_totalPriceController.text),
      deliveryFee: double.parse(_deliveryFeeController.text),
      totalAmount: double.parse(_totalAmountController.text),
      paymentMethod: _paymentMethodController.text,
      status: _statusController.text,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    try {
      await _orderService.updateOrder(updatedOrder);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đơn hàng đã được cập nhật')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật đơn hàng thất bại: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa đơn hàng'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Địa chỉ'),
            ),
            TextField(
              controller: _totalPriceController,
              decoration: const InputDecoration(labelText: 'Tổng tiền'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _deliveryFeeController,
              decoration: const InputDecoration(labelText: 'Phí giao hàng'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _totalAmountController,
              decoration: const InputDecoration(labelText: 'Tổng số tiền'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _paymentMethodController,
              decoration:
                  const InputDecoration(labelText: 'Phương thức thanh toán'),
            ),
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(labelText: 'Trạng thái'),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Ghi chú'),
              maxLines: 3,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updateOrder,
                child: const Text('Cập nhật'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
