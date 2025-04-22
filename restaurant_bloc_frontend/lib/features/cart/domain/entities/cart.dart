import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/product/data/models/product_model.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get subtotal => product.productPrice * quantity;

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['productId']).toProduct(),
      quantity: json['quantity'] as int,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
