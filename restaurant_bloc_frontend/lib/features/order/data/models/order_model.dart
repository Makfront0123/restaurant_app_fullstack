// order_data.dart (Datos)
import 'package:restaurant_bloc_frontend/features/order/data/models/order_item_data.dart';

import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';

class OrderData {
  final String id;
  final String userId;
  final List<OrderItemData> items; // <-- ESTA FALTABA
  final String status;
  final String deliveryAddress;
  final DateTime deliveryDate;
  final double totalPrice;

  OrderData({
    required this.id,
    required this.userId,
    required this.items, // <-- asegúrate que esté aquí también
    required this.status,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.totalPrice,
  });

  Order toDomain() {
    return Order(
      id: id,
      status: status,
      deliveryAddress: deliveryAddress,
      deliveryDate: deliveryDate,
      totalPrice: totalPrice,
    );
  }

  static OrderData fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['_id'] ?? '',
      userId: json['userId'] is String ? json['userId'] : json['userId']['_id'],
      items: (json['items'] as List)
          .map((item) => OrderItemData.fromJson(item))
          .toList(),
      status: json['status'],
      deliveryAddress: json['deliveryAddress'],
      deliveryDate: DateTime.parse(json['deliveryDate']),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'deliveryAddress': deliveryAddress,
      'deliveryDate': deliveryDate.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }
}
