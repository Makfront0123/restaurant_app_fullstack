import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String title;
  final String image;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, image];

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'image': image,
      };
}
