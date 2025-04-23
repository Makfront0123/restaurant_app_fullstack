class OrderItemData {
  final String productId;
  final int quantity;

  OrderItemData({
    required this.productId,
    required this.quantity,
  });

  OrderItemData toDomain() {
    return OrderItemData(
      productId: productId,
      quantity: quantity,
    );
  }

  static OrderItemData fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
