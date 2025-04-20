import 'package:restaurant_bloc_frontend/features/order/domain/entities/order.dart';

class OrderModel {
  final String deliveryAddress;
  final DateTime deliveryDate;

  OrderModel({
    required this.deliveryAddress,
    required this.deliveryDate,
  });

  factory OrderModel.fromOrder(Order order) {
    return OrderModel(
      deliveryAddress: order.deliveryAddress,
      deliveryDate: order.deliveryDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deliveryAddress': deliveryAddress,
      'deliveryDate': deliveryDate.toIso8601String(),
    };
  }
}
