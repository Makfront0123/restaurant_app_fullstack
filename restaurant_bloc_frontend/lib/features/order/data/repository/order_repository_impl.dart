import 'package:restaurant_bloc_frontend/features/order/data/datasources/remote/order_api_services.dart';
import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiServices api;

  OrderRepositoryImpl(this.api);

  @override
  Future<Order> createOrder({
    required String deliveryAddress,
    required DateTime deliveryDate,
    required String token,
  }) async {
    final response = await api.createOrder(
        deliveryAddress, deliveryDate.toIso8601String(), token);

    // Puedes verificar aquí si hubo un error, por ejemplo:
    if (response['data'] == null) {
      throw Exception(response['message'] ?? 'Unknown error creating order');
    }

    return OrderData.fromJson(response['data']).toDomain();
  }
}
