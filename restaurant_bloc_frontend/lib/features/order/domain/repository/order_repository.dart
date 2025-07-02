import 'package:restaurant_bloc_frontend/features/order/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Order> createOrder(Order order);
}
