import 'package:dio/dio.dart';

class CategoryApiServices {
  final Dio _dio;
  final String baseUrl;

  CategoryApiServices(this._dio, this.baseUrl);

  Future<dynamic> createCategory(
      String name, String description, String image) async {
    try {
      final response = await _dio.post('/api/v1/category/create-category',
          data: {'name': name, 'description': description, 'image': image});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteCategory(String id) async {
    try {
      final response =
          await _dio.delete('/api/v1/category/delete-category/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> editCategory(
      String id, String name, String description, String image) async {
    try {
      final response = await _dio.put('/api/v1/category/edit-category/$id',
          data: {'name': name, 'description': description, 'image': image});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getAllCategory() async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/all-category');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getCategory(String id) async {
    try {
      final response = await _dio.get('/api/v1/category/get-category/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
