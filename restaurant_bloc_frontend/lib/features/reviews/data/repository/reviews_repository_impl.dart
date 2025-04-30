import 'package:restaurant_bloc_frontend/features/reviews/data/datasources/remote/reviews_api_services.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/repository/reviews_repository.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsApiServices _reviewsApiServices;

  ReviewsRepositoryImpl(this._reviewsApiServices);

  @override
  Future<List<Review>> getAllReviews(String token) async {
    return await _reviewsApiServices.getAllReviews(token);
  }

  @override
  Future<Review> createReview(
    String productId,
    String author,
    String comment,
    String token,
  ) async {
    return await _reviewsApiServices.createReview(
      productId,
      author,
      comment,
      token,
    );
  }
}
