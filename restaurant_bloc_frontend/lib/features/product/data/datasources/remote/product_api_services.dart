import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ProductApiServices {
  final Dio _dio;
  final String baseUrl;

  ProductApiServices(this._dio, this.baseUrl);

  Future<dynamic> createProduct(String name, String description, String price,
      String image, String category) async {
    try {
      final response = await _dio.post('/api/v1/product/create-product', data: {
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'category': category
      });
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getProduct(String id) async {
    try {
      final response = await _dio.get('/api/v1/product/get-product/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteProduct(String id) async {
    try {
      final response = await _dio.delete('/api/v1/product/delete-product/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> editProduct(String id, String name, String description,
      String price, String image, String category) async {
    try {
      final response =
          await _dio.put('/api/v1/product/edit-product/$id', data: {
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'category': category
      });
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getAllProducts() async {
    try {
      final response = await _dio.get("$baseUrl/api/v1/all-products");
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getProductsByCategory(String category) async {
    try {
      final response =
          await _dio.get('$baseUrl/api/v1/all-products?category=$category');

      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<List<Product>> searchProducts(String query, String category) async {
    try {
      final response =
          await _dio.get('$baseUrl/api/v1/search-products', queryParameters: {
        'query': query,
        'category': category,
      });

      return (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
