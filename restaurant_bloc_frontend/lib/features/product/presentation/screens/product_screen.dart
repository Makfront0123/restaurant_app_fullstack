import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/item_product_count.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductItem?;

    if (product == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final description = product.productDescription.substring(0, 150);

    return Scaffold(
      appBar: const MenuAppbar(title: 'Product'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthContainer(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(40),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .45,
            child: Image.asset(product.image),
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
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(description,
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 50),
                ItemProductCount(itemPrice: product.productPrice),
                const SizedBox(height: 10),
                AuthButton(
                    onTap: () {
                      context
                          .read<CartBloc>()
                          .add(AddProductToCart(product: product));
                    },
                    text: 'Add to Cart')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
