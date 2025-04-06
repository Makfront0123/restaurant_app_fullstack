import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final ProductItem product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final ProductItem product;
  RemoveFromCart(this.product);
}

class CartInitial extends CartEvent {}

class CartLoading extends CartEvent {}

class CartLoaded extends CartEvent {}

class CartError extends CartEvent {
  final String message;
  CartError(this.message);
}