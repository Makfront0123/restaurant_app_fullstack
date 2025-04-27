import 'package:dio/dio.dart';

class ReviewsApiServices {
  final Dio _dio;
  final String baseUrl;

  ReviewsApiServices(this._dio, this.baseUrl);

  Future<List<dynamic>> getAllReviews() async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/all-reviews');

      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }
}
