import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';

class CategoryModel extends CategoryItem {
  CategoryModel({
    required super.id,
    required super.title,
    required super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
    );
  }
}
