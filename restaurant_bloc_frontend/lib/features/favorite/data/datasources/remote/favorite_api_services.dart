import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/favorite/data/models/favorite_model.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/entities/favorite_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class FavoriteApiServices {
  final Dio _dio;
  final String baseUrl;

  FavoriteApiServices(this._dio, this.baseUrl);

  Future<Favorite> addFavorite(String token, String productId) async {
    try {
      final response = await _dio.post(
          '$baseUrl/api/v1/add-favorite/$productId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final favoriteData = FavoriteData.fromJson(response.data['data']);
      return favoriteData.toDomain();
    } catch (e) {
      throw Exception('Error adding favorite: $e');
    }
  }

  Future<List<Product>> getFavorites(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/api/v1/get-favorites',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            return status == 200 || status == 404;
          },
        ),
      );

      if (response.statusCode == 200) {
        final items = response.data?['data']?['items'] as List<dynamic>?;
        if (items == null || items.isEmpty) {
          return [];
        }

        final productIds = items.map((item) => item['productId']).toList();

        final productFutures = productIds.map((productId) {
          return _dio.get(
            '$baseUrl/api/v1/get-product/$productId',
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
        }).toList();

        final productResponses = await Future.wait(productFutures);

        List<Product> products = [];
        for (var response in productResponses) {
          if (response.statusCode == 200) {
            products.add(Product.fromJson(response.data['data']));
          }
        }

        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Error obteniendo favoritos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error obteniendo favoritos: $e');
    }
  }
}
