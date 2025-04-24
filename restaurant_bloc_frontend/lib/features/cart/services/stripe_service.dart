import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';

class UserPayServices {
  Map<String, dynamic>? paymentIntent;

  Future<bool> makePayment(context) async {
    try {
      paymentIntent = await createPaymentIntent('3', 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: ''),
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Neha Tanwar',
        ),
      );

      await displayPaymentSheet(context);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<void> displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntent = null;
    } on StripeException catch (e) {
      // Mostrar diálogo o mensaje si querés
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment cancelled')),
      );
      throw Exception("Payment cancelled $e");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    final Dio dio = Dio();
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };
      final secretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? '';

      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: body,
      );
      return response.data;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  Future<bool> navigatePaypal(BuildContext context) async {
    Completer<bool> completer = Completer();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId:
              "AZnncQH4jDYj5394u7SiQqC30hjw_8MSRM9B865er8psIw-fRnye9A55zoQ2jO5XfwmW5w3m59HHhcO4",
          secretKey:
              "EFsHteQo_FY7QU4UIVXtW0Jls9fWn7mrwO6kSKQKE0jMfJQtnDtsYnzZRCwiT6jz1rgdhskUbkI1keRy",
          transactions: const [
            {
              "amount": {
                "total": '3',
                "currency": "USD",
                "details": {
                  "subtotal": '3',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "Templates Suscription",
                    "quantity": 1,
                    "price": '3',
                    "currency": "USD"
                  }
                ]
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            Navigator.pop(context);
            completer.complete(true); // 👈 pago exitoso
          },
          onError: (error) {
            Navigator.pop(context);
            completer.complete(false); // 👈 error en pago
          },
          onCancel: () {
            Navigator.pop(context);
            completer.complete(false); // 👈 pago cancelado
          },
        ),
      ),
    );

    return completer.future;
  }
}
