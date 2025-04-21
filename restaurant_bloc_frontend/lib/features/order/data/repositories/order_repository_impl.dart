import 'package:restaurant_bloc_frontend/features/application/services/storage_service.dart';
import 'package:restaurant_bloc_frontend/features/order/data/datasources/remote/order_api_services.dart';
import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/entities/order.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiServices api;
  final StorageService storage;

  OrderRepositoryImpl(this.api, this.storage);

  @override
  Future<Order> createOrder(Order order) async {
    final token = await storage.getToken();
    if (token == null) throw Exception("Token not found");

    final orderModel = OrderModel.fromOrder(order);
    return await api.createOrder(orderModel, token);
  }
}
