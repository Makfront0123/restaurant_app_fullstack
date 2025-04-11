import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdatedState extends CartState {
  final List<ProductItem> productsInCart;

  CartUpdatedState({required this.productsInCart});

  bool get isEmpty => productsInCart.isEmpty;
}
