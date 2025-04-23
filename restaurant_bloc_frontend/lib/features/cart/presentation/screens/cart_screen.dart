import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/widgets/checkout_content.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/widgets/payment_content.dart';
import 'package:restaurant_bloc_frontend/features/checkout/presentation/screens/paypal_screen.dart';
import 'package:restaurant_bloc_frontend/features/checkout/presentation/screens/stripe_screen.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/item_count.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (!mounted) return;
    context.read<CartBloc>().add(GetCart(token: token ?? ''));
  }

  void _onDelete(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (!mounted) return;
    context
        .read<CartBloc>()
        .add(RemoveProductFromCart(product: product, token: token ?? ''));
  }

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

            return products.isEmpty
                ? const ScreenEmpty(
                    emptyImage: Vectors.favorite,
                    title: 'Your cart is empty',
                  )
                : _buildCartContent(products);
          }

          return const ScreenEmpty(
            emptyImage: Vectors.favorite,
            title: 'Your cart is empty',
          );
        },
      ),
    );
  }

  Column _buildCartContent(List<Product> products) {
    return Column(
      children: [
        Expanded(child: _buildCartList(products)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, orderState) {
              return AuthButton(
                onTap: _onCheckout,
                text: 'Checkout',
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCartList(List<Product> products) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildCartItem(product);
            },
          ),
          PaymentContent(products: products),
          const SizedBox(height: 0),
          const CheckoutContent(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCartItem(Product product) {
    const String baseUrl = 'http://10.0.2.2:3000/';
    return Dismissible(
      key: Key(product.productName),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        _onDelete(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 1),
              content: Text('${product.productName} removed from cart')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AuthContainer(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network('$baseUrl${product.image}', height: 90),
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
              ItemCount(
                direction: Axis.vertical,
                product: product,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCheckout() {
    final orderState = context.read<OrderBloc>().state;

    if (orderState is PaymentMethodSelected) {
      final method = orderState.selectedPaymentMethod;

      if (method == 'stripe') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StripeScreen(),
          ),
        );
      } else if (method == 'paypal') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PaypalScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a payment method'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
        ),
      );
    }
  }
}
