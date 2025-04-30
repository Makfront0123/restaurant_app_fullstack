import 'package:restaurant_bloc_frontend/features/order/data/datasources/remote/order_api_services.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/entities/order_item.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiServices api;

  OrderRepositoryImpl(this.api);

  @override
  Future<Order> createOrder(
    String deliveryAddress,
    DateTime deliveryDate,
    String token,
  ) async {
    return await api.createOrder(
      deliveryAddress,
      deliveryDate.toIso8601String(),
      token,
    );
  }

  @override
  Future<List<Order>> getOrderByUser(String token) async {
    final response = await api.getOrderByUser(token);

    // Mapear cada OrderData a Order
    return response.map((orderData) => orderData.toDomain()).toList();
  }
}
