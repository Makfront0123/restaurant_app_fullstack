abstract class ReviewEvent {}

class LoadReviewsEvent extends ReviewEvent {
  final String token;

  LoadReviewsEvent({required this.token});
}

class CreateReviewEvent extends ReviewEvent {
  final String productId;
  final String author;
  final String comment;
  final String token;

  CreateReviewEvent({
    required this.productId,
    required this.author,
    required this.comment,
    required this.token,
  });
}
