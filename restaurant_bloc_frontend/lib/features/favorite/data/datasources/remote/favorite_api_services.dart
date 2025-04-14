import 'package:dio/dio.dart';

class FavoriteApiServices {
  final Dio _dio;

  FavoriteApiServices(this._dio);

  Future<dynamic> addFavorite(String productId) async {
    try {
      final response =
          await _dio.post('/api/v1/favorites/add-favorite/$productId');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteFavorite(String productId) async {
    try {
      final response =
          await _dio.delete('/api/v1/favorites/delete-favorite/$productId');
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
