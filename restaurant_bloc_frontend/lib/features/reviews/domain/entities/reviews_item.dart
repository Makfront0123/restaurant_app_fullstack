class Review {
  final String author;
  final String imageUser;
  final String review;
  final DateTime date;
  final String comment;

  Review({
    required this.author,
    required this.imageUser,
    required this.review,
    required this.comment,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
      author: json['author'],
      imageUser: json['imageUser'],
      review: json['review'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'comment': comment,
      };
}
