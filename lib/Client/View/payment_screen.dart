import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import '../Models/product.dart';

class PayPalPaymentScreen extends StatefulWidget {
  final Product product;

  PayPalPaymentScreen({required this.product});

  @override
  _PayPalPaymentScreenState createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => UsePaypal(
                    sandboxMode: true,
                    clientId:
                        "AUGRGzwsAaeHAwrH9SEWZP3ySsxktWduOTqVNi_xVJO1WSefNxgkgWAroiizz3YX_ucQud_5Bz_dWYyD",
                    secretKey:
                        "EH4u_5fIOaVOJrwiPuLISiJ3au09h22iAMUNZfY2alkxmdz6m2Q6KeqtAtZtYHztScbnuyrj9YLZ5_bC",
                    returnURL: "https://samplesite.com/return",
                    cancelURL: "https://samplesite.com/cancel",
                    transactions: [
                      {
                        "amount": {
                          "total": '${widget.product.price}',
                          "currency": "USD",
                          "details": {
                            "subtotal": '${widget.product.price}',
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "Payment for ${widget.product.name}",
                        "item_list": {
                          "items": [
                            {
                              "name": widget.product.name,
                              "quantity": 1,
                              "price": '${widget.product.price}',
                              "currency": "USD"
                            }
                          ],
                          "shipping_address": {
                            "recipient_name": "Jane Foster",
                            "line1": "Travis County",
                            "line2": "",
                            "city": "Austin",
                            "country_code": "US",
                            "postal_code": "73301",
                            "phone": "+00000000",
                            "state": "Texas"
                          },
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                      // Implement additional success operations here
                    },
                    onError: (error) {
                      print("onError: $error");
                      // Handle errors here
                    },
                    onCancel: (params) {
                      print('cancelled: $params');
                      // Implement any operation on cancellation
                    }),
              ),
            );
          },
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}
