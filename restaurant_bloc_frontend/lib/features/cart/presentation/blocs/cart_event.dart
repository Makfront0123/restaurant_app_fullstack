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

class UpdateProductCount extends CartEvent {
  final Product product;
  final int count;

  UpdateProductCount({required this.product, required this.count});
}
