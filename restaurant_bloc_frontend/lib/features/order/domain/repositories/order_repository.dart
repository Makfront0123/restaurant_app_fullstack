import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';

abstract class OrderRepository {
  Future<Order> createOrder({
    required String deliveryAddress,
    required DateTime deliveryDate,
    required String token,
  });

  Future<List<Order>> getOrderByUser(String token);
}
