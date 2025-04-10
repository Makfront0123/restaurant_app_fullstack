import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartEvent {}

class CartLoaded extends CartEvent {}

class AddProductToCart extends CartEvent {
  final ProductItem product;

  AddProductToCart({required this.product});
}

class RemoveProductFromCart extends CartEvent {
  final ProductItem product;

  RemoveProductFromCart({required this.product});
}

class IncrementProductCount extends CartEvent {
  final ProductItem product;
  IncrementProductCount({required this.product});
}

class DecrementProductCount extends CartEvent {
  final ProductItem product;
  DecrementProductCount({required this.product});
}
