import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/entities/order.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repository/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder(this.repository);

  Future<Order> call(OrderModel request, String token) {
    return repository.createOrder(
      Order(
        deliveryAddress: request.deliveryAddress,
        deliveryDate: request.deliveryDate,
      ),
    );
  }
}
