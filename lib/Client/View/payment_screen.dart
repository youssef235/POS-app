import 'package:flutter/material.dart';
import 'package:pos_client_final/Client/Services/payment_services.dart';
import '../Models/product.dart';

class PayPalPaymentScreen extends StatefulWidget {
  final Product product;

  PayPalPaymentScreen({required this.product});

  @override
  _PayPalPaymentScreenState createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  final PayPalService _payPalService = PayPalService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pay with PayPal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _payPalService.makePayment(
              context: context,
              product: widget.product,
              onSuccess: (Map params) {
                print("onSuccess: $params");
              },
              onError: (error) {
                print("onError: $error");
              },
              onCancel: (params) {
                print('cancelled: $params');
              },
            );
          },
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}
