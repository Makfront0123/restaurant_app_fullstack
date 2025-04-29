import 'package:restaurant_bloc_frontend/features/reviews/domain/repository/reviews_repository.dart';

class CreateReviewsUsecase {
  final ReviewsRepository _reviewsRepository;

  CreateReviewsUsecase(this._reviewsRepository);

  Future<dynamic> createReview(
      String productId, String author, String comment, String token) async {
    return await _reviewsRepository.createReview(
        productId, author, comment, token);
  }
}
