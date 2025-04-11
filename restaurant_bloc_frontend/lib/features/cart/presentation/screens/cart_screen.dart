import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/widgets/checkout_content.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/item_count.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppbar(
        title: 'Cart',
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdatedState) {
            final products = state.productsInCart;

            return _buildCartList(products);
          }
          return const ScreenEmpty(
            emptyImage: Vectors.favorite,
            title: 'Your cart is empty',
          );
        },
      ),
    );
  }

  Widget _buildCartList(List<ProductItem> products) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // evita conflicto con SingleChildScrollView
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildCartItem(product);
            },
          ),
          const SizedBox(height: 30),
          const CheckoutContent(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AuthButton(
              onTap: () {},
              text: 'Checkout',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(ProductItem product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AuthContainer(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product.image, height: 90),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "\$${product.productPrice}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const ItemCount(direction: Axis.vertical),
          ],
        ),
      ),
    );
  }
}
