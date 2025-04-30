import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';

class ReviewsApiServices {
  final Dio _dio;
  final String baseUrl;

  ReviewsApiServices(this._dio, this.baseUrl);

  Future<List<Review>> getAllReviews(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/api/v1/all-reviews',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List<dynamic> reviewsJson = response.data['data'];
      return reviewsJson
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Review> createReview(
    String productId,
    String author,
    String comment,
    String token,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/v1/create-review/$productId',
        data: {
          'productId': productId,
          'author': author,
          'comment': comment,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
