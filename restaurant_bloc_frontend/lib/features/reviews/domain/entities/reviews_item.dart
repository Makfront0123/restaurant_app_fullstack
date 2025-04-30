import 'package:restaurant_bloc_frontend/core/constants/images.dart';

class Review {
  final String id;
  final String productId;
  final String author;
  final String comment;
  final DateTime date;
  final String imageUser;

  Review({
    required this.id,
    required this.productId,
    required this.author,
    required this.comment,
    required this.date,
    required this.imageUser,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      author: json['author'] ?? '',
      comment: json['comment'] ?? '',
      date: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      imageUser: json['imageUser'] ?? Images.user,
    );
  }
}
