import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class CreateOrderUsecase {
  final OrderRepository repository;
  CreateOrderUsecase(this.repository);

  Future<void> call(List<Product> products) async {
    await repository.createOrder(products);
  }
}
