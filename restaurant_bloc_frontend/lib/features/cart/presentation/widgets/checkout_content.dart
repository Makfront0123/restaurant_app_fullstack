import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';

class CheckoutContent extends StatelessWidget {
  const CheckoutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartUpdatedState) {
          final products = state.productsInCart;

          final double subtotal = products.fold(
            0.0,
            (total, product) =>
                total + (product.productPrice * product.productCount),
          );
          const double deliveryFee = 2.0;
          final double total = subtotal + deliveryFee;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildCheckoutTop(context, subtotal, deliveryFee),
                    _buildCheckoutBottom(context, total),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildCheckoutTop(
      BuildContext context, double subtotal, double deliveryFee) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).shadowColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sub Total',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text('Delivery', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${subtotal.toStringAsFixed(2)}'),
              Text('\$${deliveryFee.toStringAsFixed(2)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBottom(BuildContext context, double total) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total', style: Theme.of(context).textTheme.headlineMedium),
          Text('\$${total.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
