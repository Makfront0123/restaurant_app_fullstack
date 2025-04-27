import 'package:restaurant_bloc_frontend/features/favorite/domain/entities/favorite_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class FavoriteRepository {
  Future<Favorite> addFavorite(String token, Product product);
  Future<List<Product>> getFavorites(String token);
}
