import 'package:restaurant_bloc_frontend/features/order/domain/entities/order_item.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;
  CreateOrderUsecase(this.repository);

  Future<Order> call({
    required String deliveryAddress,
    required DateTime deliveryDate,
    required String token,
  }) async {
    return await repository.createOrder(deliveryAddress, deliveryDate, token);
  }
}
