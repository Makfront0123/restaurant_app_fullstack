import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';

abstract class ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewLoadedState extends ReviewState {
  final List<Review> reviews;
  ReviewLoadedState({required this.reviews});
}

class ReviewErrorState extends ReviewState {
  final String error;
  ReviewErrorState({required this.error});
}
