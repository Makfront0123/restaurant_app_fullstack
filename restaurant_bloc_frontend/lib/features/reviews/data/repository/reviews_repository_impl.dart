import 'package:restaurant_bloc_frontend/features/reviews/data/datasources/remote/reviews_api_services.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/repository/reviews_repository.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsApiServices _reviewsApiServices;

  ReviewsRepositoryImpl(this._reviewsApiServices);

  @override
  Future<List<Review>> getAllReviews() async {
    final rawData = await _reviewsApiServices.getAllReviews();

    return rawData.map<Review>((json) => Review.fromJson(json)).toList();
  }
}
