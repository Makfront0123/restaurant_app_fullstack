import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class PaymentContent extends StatelessWidget {
  final List<Product> products;
  const PaymentContent({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        String selectedMethod = '';
        if (state is PaymentMethodSelected) {
          selectedMethod = state.selectedPaymentMethod;
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<OrderBloc>().add(SelectPaymentMethod(
                        paymentMethod: 'stripe',
                        products: products,
                      ));
                },
                style: ButtonStyle(
                  backgroundColor: selectedMethod == 'stripe'
                      ? WidgetStateProperty.all(Colors.blue)
                      : WidgetStateProperty.all(Colors.grey),
                ),
                child: const Text('Pay with Stripe'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<OrderBloc>().add(SelectPaymentMethod(
                        paymentMethod: 'paypal',
                        products: products,
                      ));
                },
                style: ButtonStyle(
                  backgroundColor: selectedMethod == 'paypal'
                      ? WidgetStateProperty.all(Colors.blue)
                      : WidgetStateProperty.all(Colors.grey),
                ),
                child: const Text('Pay with PayPal'),
              ),
            ],
          ),
        );
      },
    );
  }
}
