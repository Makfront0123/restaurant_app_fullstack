import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/entities/order_item.dart';

class OrderApiServices {
  final Dio _dio;
  final String baseUrl;

  OrderApiServices(this._dio, this.baseUrl);

  Future<Order> createOrder(
      String deliveryAddress, String deliveryDate, String token) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/v1/create-order',
        data: {
          'deliveryAddress': deliveryAddress,
          'deliveryDate': deliveryDate,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];

        if (data != null) {
          final orderData = OrderData.fromJson(data);
          return orderData.toDomain();
        } else {
          throw Exception('La respuesta no contiene datos');
        }
      } else {
        throw Exception('La respuesta tiene un formato inesperado');
      }
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  Future<List<OrderData>> getOrderByUser(String token,
      {String? filterStatus}) async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/get-order-by-user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final data = response.data['data'];
      if (data is List) {
        return data.map((orderJson) => OrderData.fromJson(orderJson)).toList();
      } else if (data is Map<String, dynamic>) {
        return [OrderData.fromJson(data)];
      } else {
        throw Exception('Formato de datos inesperado');
      }
    } catch (e) {
      throw Exception('Error getting orders: $e');
    }
  }
}
