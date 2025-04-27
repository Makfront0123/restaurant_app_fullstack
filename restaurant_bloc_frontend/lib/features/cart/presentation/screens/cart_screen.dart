// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/application/presentation/widgets/load_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/widgets/checkout_content.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/widgets/payment_content.dart';
import 'package:restaurant_bloc_frontend/features/cart/services/stripe_service.dart';

import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/screens/order_failed.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/screens/order_success_screen.dart';
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

  void _onCheckout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final orderState = context.read<OrderBloc>().state;

    if (orderState is PaymentMethodSelected) {
      final method = orderState.selectedPaymentMethod;
      if (method == 'stripe') {
        final userPayService = UserPayServices();
        try {
          final success = await userPayService.makePayment(context);
          if (success) {
            final event = CreateOrderEvent(
              comment: 'Pago con Stripe',
              deliveryAddress: 'Tu dirección',
              deliveryDate: DateTime.now().add(const Duration(days: 2)),
              token: token,
            );
            context.read<OrderBloc>().add(event);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al pagar')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al pagar')),
          );
        }
      } else if (method == 'paypal') {
        final userPayService = UserPayServices();
        try {
          final success = await userPayService.navigatePaypal(context);
          if (success) {
            final event = CreateOrderEvent(
              comment: 'Pago con Paypal',
              deliveryAddress: 'Tu dirección',
              deliveryDate: DateTime.now().add(const Duration(days: 2)),
              token: token,
            );
            context.read<OrderBloc>().add(event);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al pagar')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al pagar')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OrderSuccess()),
          );
        } else if (state is OrderFailed) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OrderFailedScreen()),
          );
        }
      },
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          final isLoading = state is OrderCreating;

          return LoadScreen(
            isLoading: isLoading,
            child: Scaffold(
              appBar: const MenuAppbar(title: 'Cart'),
              body: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartUpdatedState) {
                    final products = state.productsInCart;
                    return products.isEmpty
                        ? const ScreenEmpty(
                            emptyImage: Vectors.favorite,
                            title: 'Your cart is empty',
                          )
                        : _buildCartContent(products, state);
                  }

                  return const ScreenEmpty(
                    emptyImage: Vectors.favorite,
                    title: 'Your cart is empty',
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildCartContent(List<Product> products, CartState state) {
    return Column(
      children: [
        Expanded(child: _buildCartList(products, state)),
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

  Widget _buildCartList(List<Product> products, CartState state) {
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
              return _buildCartItem(product, state);
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

  Widget _buildCartItem(Product product, CartState state) {
    const String baseUrl = 'http://10.0.2.2:3000/';

    Product updatedProduct = product.copyWith(productCount: 2);
    if (state is CartUpdatedState) {
      final foundProduct = state.productsInCart.firstWhere(
        (p) => p.productName == product.productName,
        orElse: () => updatedProduct,
      );
      updatedProduct = foundProduct;
    }

    return Dismissible(
      key: Key(updatedProduct.productName),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        _onDelete(updatedProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 1),
              content: Text('${updatedProduct.productName} removed from cart')),
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
              Image.network('$baseUrl${updatedProduct.image}', height: 90),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      updatedProduct.productName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "\$${updatedProduct.productPrice}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ItemCount(
                direction: Axis.vertical,
                product: updatedProduct,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
