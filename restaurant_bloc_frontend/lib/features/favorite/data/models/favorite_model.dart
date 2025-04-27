import 'package:restaurant_bloc_frontend/features/favorite/domain/entities/favorite_item.dart';

class FavoriteData {
  final String id;
  final String userId;
  final List<String> productIds; // Esto es una lista de productId
  final DateTime createdAt;

  FavoriteData({
    required this.id,
    required this.userId,
    required this.productIds, // Cambié items por productIds
    required this.createdAt,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return FavoriteData(
      id: data['_id'],
      userId: data['userId'],
      productIds: List<String>.from(
        (data['items'] as List).map((item) => item['productId']),
      ), // Aquí estamos extrayendo los productIds
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
}

extension FavoriteMapper on FavoriteData {
  Favorite toDomain() {
    return Favorite(
      id: id,
      userId: userId,
      productIds: productIds, // Accedemos a productIds, no a items
      createdAt: createdAt,
    );
  }
}
