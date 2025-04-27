import 'package:restaurant_bloc_frontend/features/product/data/models/product_model.dart';

class OrderItemData {
  final ProductModel product; // <- usamos ProductModel directamente
  final int quantity;

  OrderItemData({
    required this.product,
    required this.quantity,
  });

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      product: ProductModel.fromJson(json['productId']), // <- tu JSON viene así
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': product.toJson(),
      'quantity': quantity,
    };
  }
}
