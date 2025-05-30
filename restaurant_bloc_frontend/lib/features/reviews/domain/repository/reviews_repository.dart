import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';

abstract class ReviewsRepository {
  Future<List<Review>> getAllReviews(String token);
  Future<Review> createReview(
    String productId,
    String author,
    String comment,
    String token,
  );
}
