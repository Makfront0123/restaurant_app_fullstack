import 'package:dio/dio.dart';

class OrderApiServices {
  final Dio _dio;
  final String baseUrl;
  OrderApiServices(this._dio, this.baseUrl);

  Future<dynamic> createOrder(
      String deliveryAddress, String deliveryDate) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/order/create-order',
          data: {
            'deliveryAddress': deliveryAddress,
            'deliveryDate': deliveryDate
          });
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getOrder(String id) async {
    try {
      final response = await _dio.get('/api/v1/order/get-order/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getAllOrders() async {
    try {
      final response = await _dio.get('/api/v1/order/all-orders');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteOrder(String id) async {
    try {
      final response = await _dio.delete('/api/v1/order/delete-order/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
