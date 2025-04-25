import 'package:restaurant_bloc_frontend/features/favorite/data/datasources/remote/favorite_api_services.dart';

import 'package:restaurant_bloc_frontend/features/favorite/domain/entities/favorite_item.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/repository/favorite_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteApiServices favoriteApiServices;

  FavoriteRepositoryImpl(this.favoriteApiServices);
  @override
  Future<Favorite> addFavorite(String token, Product product) async {
    return await favoriteApiServices.addFavorite(token, product.id);
  }

  @override
  Future<List<Product>> getFavorites(String token) async {
    return await favoriteApiServices.getFavorites(token);
  }
}
