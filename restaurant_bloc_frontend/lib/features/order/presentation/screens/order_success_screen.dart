import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenEmpty(
      emptyImage: Vectors.orderSuccess,
      title: 'Your Order is Successful',
      onTap: () => Navigator.pushReplacementNamed(context, '/application'),
    ));
  }
}
