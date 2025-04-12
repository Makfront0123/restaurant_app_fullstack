import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/checkout/presentation/widgets/order_info.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartBloc>().state;

    if (cartState is CartUpdatedState) {
      return Scaffold(
          appBar: AppBar(title: const Text("Checkout")),
          body: const OrderInfo());
    }

    return const Scaffold(
      body: Center(child: Text("No products in cart")),
    );
  }
}
