import 'package:flutter/material.dart';

class StripeScreen extends StatelessWidget {
  const StripeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: const Center(
          child: Text("Stripe Screen"),
        ));
  }
}
