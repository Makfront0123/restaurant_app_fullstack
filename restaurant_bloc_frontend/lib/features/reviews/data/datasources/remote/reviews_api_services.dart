import 'package:dio/dio.dart';

class ReviewsApiServices {
  final Dio _dio;

  ReviewsApiServices(this._dio);

  Future<dynamic> createReview(
      String productId, String author, String comment) async {
    try {
      final response = await _dio.post(
          '/api/v1/reviews/create-review/$productId',
          data: {'author': author, 'comment': comment});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getReview(String id) async {
    try {
      final response = await _dio.get('/api/v1/reviews/get-review/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> deleteReview(String id) async {
    try {
      final response = await _dio.delete('/api/v1/reviews/delete-review/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getAllReviews(String id) async {
    try {
      final response = await _dio.get('/api/v1/reviews/all-reviews/$id');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> editReview(String id, String author, String comment) async {
    try {
      final response = await _dio.put('/api/v1/reviews/edit-review/$id',
          data: {'author': author, 'comment': comment});
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
