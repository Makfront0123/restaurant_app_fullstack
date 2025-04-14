import 'package:dio/dio.dart';

class ProductApiServices {
  final Dio _dio;

  ProductApiServices(this._dio);

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
      final response = await _dio.get('/api/v1/product/all-products');
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
