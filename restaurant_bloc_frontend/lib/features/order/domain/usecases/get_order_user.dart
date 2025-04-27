import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';

class GetOrderUsercase {
  final OrderRepository repository;

  GetOrderUsercase(this.repository);

  Future<List<Order>> call({required String token}) async {
    return await repository.getOrderByUser(token);
  }
}
