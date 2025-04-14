import 'package:dio/dio.dart';

class CartApiServices {
  final Dio _dio;

  CartApiServices(this._dio);

  Future<dynamic> addToCart(String productId, int quantity) async {
    try {
      final response = await _dio.post('/api/v1/cart/add-cart/$productId',
          data: {'quantity': quantity});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getCart() async {
    try {
      final response = await _dio.get('/api/v1/cart/all-cart');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteProductFromCart(String productId) async {
    try {
      final response = await _dio.delete('/api/v1/cart/delete-cart/$productId');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> clearCart() async {
    try {
      final response = await _dio.delete('/api/v1/cart/clear-cart');
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
