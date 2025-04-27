// order_api_services.dart
import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';

class OrderApiServices {
  final Dio _dio;
  final String baseUrl;

  OrderApiServices(this._dio, this.baseUrl);

  Future<Map<String, dynamic>> createOrder(
      String deliveryAddress, String deliveryDate, String token) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/create-order',
          data: {
            'deliveryAddress': deliveryAddress,
            'deliveryDate': deliveryDate,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  Future<List<OrderData>> getOrderByUser(String token,
      {String? filterStatus}) async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/get-order-by-user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final List<dynamic> ordersJson = response.data['data'];

      List<OrderData> orders =
          ordersJson.map((orderJson) => OrderData.fromJson(orderJson)).toList();

      if (filterStatus != null) {
        orders = orders.where((order) => order.status == filterStatus).toList();
      }

      return orders;
    } catch (e) {
      throw Exception('Error getting orders: $e');
    }
  }
}
