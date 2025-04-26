import 'package:dio/dio.dart';

class HomeApiServices {
  final String baseUrl;
  final Dio _dio;

  HomeApiServices(this.baseUrl, this._dio);

  Future<dynamic> getCategories() async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/all-category');

      return response.data;
    } catch (e) {
      return e;
    }
  }
}
