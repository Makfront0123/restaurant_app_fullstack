class OrderItemData {
  final String productId;
  final int quantity;

  OrderItemData({required this.productId, required this.quantity});

  factory OrderItemData.fromJson(Map<String, dynamic> json) {
    return OrderItemData(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
