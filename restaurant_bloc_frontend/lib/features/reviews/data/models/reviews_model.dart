import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';

class ReviewsModel {
  final String author;
  final String imageUser;
  final String review;
  final DateTime date;

  ReviewsModel({
    required this.author,
    required this.imageUser,
    required this.review,
    required this.date,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      author: json['author'],
      imageUser: json['imageUser'],
      review: json['review'],
      date: DateTime.parse(json['date']),
    );
  }
}
