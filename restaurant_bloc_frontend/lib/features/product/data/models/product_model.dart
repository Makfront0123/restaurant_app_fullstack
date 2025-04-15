import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int weight;
  final bool isFavorite;
  final String? category;
  final DateTime? dateAdded;
  final List<Review> reviews;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.weight,
    required this.isFavorite,
    this.category,
    this.dateAdded,
    this.reviews = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        price,
        weight,
        isFavorite,
        category,
        dateAdded,
        reviews,
      ];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      weight: json['productWeight'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      category: json['category'],
      dateAdded:
          json['dateAdded'] != null ? DateTime.parse(json['dateAdded']) : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((r) => Review.fromJson(r)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'price': price,
        'quantity': weight,
        'isFavorite': isFavorite,
        'category': category,
        'dateAdded': dateAdded?.toIso8601String(),
        'reviews': reviews.map((r) => r.toJson()).toList(),
      };

  Product toProduct() {
    return Product(
      image: image,
      productName: name,
      productPrice: price,
      productWeight: weight, // asumimos que quantity representa el peso
      category: category ?? 'Unknown',
      kcal: 140, // si no lo recibís del backend, un valor por defecto
      productDescription: description,
    );
  }
}

class Review extends Equatable {
  final String author;
  final String comment;

  const Review({
    required this.author,
    required this.comment,
  });

  @override
  List<Object?> get props => [author, comment];

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'] ?? '',
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'comment': comment,
      };
}
