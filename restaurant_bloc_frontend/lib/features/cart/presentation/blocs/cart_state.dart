import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdatedState extends CartState {
  final List<ProductItem> productsInCart;

  CartUpdatedState({required this.productsInCart});

  bool get isEmpty => productsInCart.isEmpty;
}

class CartIncrementdState extends CartState {
  final ProductItem product;

  CartIncrementdState({required this.product});
}

class CartDecrementdState extends CartState {
  final ProductItem product;

  CartDecrementdState({required this.product});
}

class CartRemoveState extends CartState {
  final ProductItem product;

  CartRemoveState({required this.product});
}
