import 'package:restaurant_bloc_frontend/features/order/domain/entities/order_item.dart';

abstract class OrderRepository {
  Future<Order> createOrder(
    String deliveryAddress,
    DateTime deliveryDate,
    String token,
  );

  Future<List<Order>> getOrderByUser(String token);
}
