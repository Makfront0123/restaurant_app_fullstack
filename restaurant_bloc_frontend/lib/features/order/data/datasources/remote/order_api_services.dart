import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/entities/order.dart';

class OrderApiServices {
  final Dio dio;
  final String baseUrl;
  OrderApiServices(this.dio, this.baseUrl);

  Future<Order> createOrder(OrderModel orderRequest, String token) async {
    try {
      final response = await dio.post(
        '/orders', // O la ruta correspondiente
        data: orderRequest.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error creating order');
    }
  }
}
