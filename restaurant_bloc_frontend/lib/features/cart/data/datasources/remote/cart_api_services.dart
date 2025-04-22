import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';
import 'package:restaurant_bloc_frontend/features/product/data/models/product_model.dart';

class CartApiServices {
  final Dio _dio;
  final String baseUrl;
  CartApiServices(this._dio, this.baseUrl);

  Future<ProductModel> addToCart(CartItem item, String token) async {
    final response = await _dio.post(
      '$baseUrl/api/v1/add-cart/${item.product.id}',
      data: {'quantity': item.quantity},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return ProductModel.fromJson(response.data['data']);
  }

  Future<ProductModel> deleteProductFromCart(
      String productId, String token) async {
    final response = await _dio.delete(
      '$baseUrl/api/v1/delete-cart/$productId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return ProductModel.fromJson(response.data['data']);
  }

  Future<List<CartItem>> getCart(String token) async {
    final response = await _dio.get(
      '$baseUrl/api/v1/get-cart',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.data['data'] != null) {
      final cartData = response.data['data'];
      return (cartData['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
    } else {
      throw Exception("No cart data available");
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
