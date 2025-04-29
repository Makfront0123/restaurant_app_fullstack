import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/repository/reviews_repository.dart';

class GetReviewsUsecase {
  final ReviewsRepository _repository;

  GetReviewsUsecase(this._repository);

  Future<List<Review>> getReviews(String token) async {
    return await _repository.getAllReviews(token);
  }
}
