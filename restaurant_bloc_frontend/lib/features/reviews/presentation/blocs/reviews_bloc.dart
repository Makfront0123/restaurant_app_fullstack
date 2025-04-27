import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/reviews/domain/usecase/get_reviews.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_event.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetReviewsUsecase _getReviews;

  ReviewsBloc({
    required GetReviewsUsecase getReviews,
  })  : _getReviews = getReviews,
        super(ReviewLoadingState()) {
    on<LoadReviewsEvent>(_onLoadReviews);

    ///on<CreateReviewEvent>(_onCreateReview);
  }

  Future<void> _onLoadReviews(
      LoadReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewLoadingState());
    try {
      final reviews = await _getReviews.getReviews();
      emit(ReviewLoadedState(reviews: reviews));
    } catch (e) {
      emit(ReviewErrorState(error: e.toString()));
    }
  }
/*

  Future<void> _onCreateReview(
      CreateReviewEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewLoadingState());
    try {
      final reviews = await _createReviews.createReview(
          event.productId, event.author, event.comment, event.token);
      emit(ReviewLoadedState(reviews: reviews));
    } catch (e) {
      emit(ReviewErrorState(error: e.toString()));
    }
  }
 */
}
