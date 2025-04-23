import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;
  CreateOrderUsecase(this.repository);

  Future<Order> call({
    required String deliveryAddress,
    required DateTime deliveryDate,
    required String token,
  }) async {
    return await repository.createOrder(
      deliveryAddress: deliveryAddress,
      deliveryDate: deliveryDate,
      token: token,
    );
  }
}
