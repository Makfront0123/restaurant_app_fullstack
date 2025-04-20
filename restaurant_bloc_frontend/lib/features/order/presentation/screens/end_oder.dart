import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';

class EndOrderScreen extends StatefulWidget {
  const EndOrderScreen({super.key});

  @override
  State<EndOrderScreen> createState() => _EndOrderScreenState();
}

class _EndOrderScreenState extends State<EndOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenEmpty(
        emptyImage: Vectors.orderSuccess,
        title: 'Thank you for your order',
      ),
    );
  }
}
