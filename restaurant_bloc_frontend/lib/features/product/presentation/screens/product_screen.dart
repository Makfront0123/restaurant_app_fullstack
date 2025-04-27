import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';

import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    if (product == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final description = product.productDescription.substring(0, 150);
    const String baseUrl = 'http://10.0.2.2:3000/';

    return Scaffold(
      appBar: const MenuAppbar(title: 'Product'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthContainer(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(40),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .42,
            child: Image.network('$baseUrl${product.image}'),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "${product.kcal}-${product.productWeight}gr",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(description,
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 50),
                AuthButton(
                  onTap: () {
                    context
                        .read<CartBloc>()
                        .add(AddProductToCart(product: product));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 1),
                        content: Text('${product.productName} added to cart'),
                      ),
                    );
                  },
                  text: 'Add to Cart',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
