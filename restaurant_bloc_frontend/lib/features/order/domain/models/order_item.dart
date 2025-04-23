class Order {
  final String id;
  final String status;
  final double totalPrice;
  final String deliveryAddress;
  final DateTime deliveryDate;

  Order({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.deliveryAddress,
    required this.deliveryDate,
  });
}
