import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdatedState extends CartState {
  final List<Product> productsInCart;

  CartUpdatedState({required this.productsInCart});

  bool get isEmpty => productsInCart.isEmpty;
}

class CartErrorState extends CartState {
  final String message;

  CartErrorState({required this.message});
}

class CartIncrementdState extends CartState {
  final Product product;

  CartIncrementdState({required this.product});
}

class CartDecrementdState extends CartState {
  final Product product;

  CartDecrementdState({required this.product});
}

class CartRemoveState extends CartState {
  final Product product;

  CartRemoveState({required this.product});
}
