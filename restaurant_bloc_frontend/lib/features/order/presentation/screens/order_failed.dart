import 'package:flutter/material.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        child: const Center(
          child: Text('Order Failed'),
        ),
      ),
    );
  }
}
