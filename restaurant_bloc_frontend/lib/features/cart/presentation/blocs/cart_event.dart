import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartEvent {}

class CartLoaded extends CartEvent {}

class AddProductToCart extends CartEvent {
  final Product product;

  AddProductToCart({required this.product});
}

class GetCart extends CartEvent {
  final String token;

  GetCart({required this.token});

  List<Object?> get props => [token];
}

class RemoveProductFromCart extends CartEvent {
  final Product product;
  final String token;

  RemoveProductFromCart({required this.product, required this.token});
}

class IncrementProductCount extends CartEvent {
  final Product product;
  IncrementProductCount({required this.product});
}

class DecrementProductCount extends CartEvent {
  final Product product;
  DecrementProductCount({required this.product});
}
