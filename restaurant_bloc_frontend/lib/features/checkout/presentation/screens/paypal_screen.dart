import 'package:flutter/material.dart';

class PaypalScreen extends StatelessWidget {
  const PaypalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: const Center(
          child: Text("Paypal Screen"),
        ));
  }
}
