// order_api_services.dart
import 'package:dio/dio.dart';

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

      return response
          .data; // Asumiendo que la API devuelve la respuesta en el formato adecuado.
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }
}
