import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter/material.dart';
import '../Models/product.dart';

class PayPalService {
  Future<void> makePayment({
    required BuildContext context,
    required Product product,
    required Function(Map params) onSuccess,
    required Function(dynamic error) onError,
    required Function(Map params) onCancel,
  }) async {
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
                "total": '${product.price}',
                "currency": "USD",
                "details": {
                  "subtotal": '${product.price}',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "Payment for ${product.name}",
              "item_list": {
                "items": [
                  {
                    "name": product.name,
                    "quantity": 1,
                    "price": '${product.price}',
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
          onSuccess: onSuccess,
          onError: onError,
          onCancel: onCancel,
        ),
      ),
    );
  }
}
