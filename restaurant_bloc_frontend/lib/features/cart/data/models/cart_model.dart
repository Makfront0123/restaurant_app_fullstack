import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';

class Cart extends Equatable {
  final List<CartItem> items;

  const Cart({required this.items});

  double get totalPrice => items.fold(0, (sum, item) => sum + item.subtotal);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
      };

  factory Cart.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List)
        .map((e) => CartItem.fromJson(e as Map<String,
            dynamic>))
        .toList();

    return Cart(items: items);
  }

  @override
  List<Object?> get props => [items];
}
