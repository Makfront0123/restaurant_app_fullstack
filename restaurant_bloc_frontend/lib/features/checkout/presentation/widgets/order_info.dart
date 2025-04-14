import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOrderSummary(
                    context, products, subtotal, deliveryFee, total),
                _buildOrderComment(context)
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Container _buildOrderComment(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .45,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Comentario',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo no puede estar vacío';
                }
                return null;
              },
            ),
            const Spacer(),
            AuthButton(
              onTap: () {},
              text: 'Place Order',
            )
          ],
        ),
      ),
    );
  }

  Container _buildOrderSummary(BuildContext context, List<Product> products,
      double subtotal, double deliveryFee, double total) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Order Summary',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...products.map((product) => _buildProductRow(product)),
              const Divider(thickness: 2, height: 30),
              _buildCheckoutTop(context, subtotal, deliveryFee),
              const SizedBox(height: 10),
              _buildCheckoutBottom(context, total),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductRow(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${product.productCount} x ${product.productName}',
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '\$${(product.productPrice * product.productCount).toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutTop(
      BuildContext context, double subtotal, double deliveryFee) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Subtotal:'),
        Text('\$${subtotal.toStringAsFixed(2)}'),
        const Text('Delivery:'),
        Text('\$${deliveryFee.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildCheckoutBottom(BuildContext context, double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
