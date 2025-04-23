import 'package:restaurant_bloc_frontend/features/order/data/datasources/remote/order_api_services.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiServices orderApiServices;

  OrderRepositoryImpl(this.orderApiServices);

  @override
  Future<void> createOrder(List<Product> products) async {
    await orderApiServices.createOrder(
        DateTime.now().toIso8601String(), DateTime.now().toIso8601String());
  }
}
