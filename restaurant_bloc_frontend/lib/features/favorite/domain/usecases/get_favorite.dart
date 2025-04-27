import 'package:restaurant_bloc_frontend/features/favorite/domain/repository/favorite_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class GetFavoriteUsecase {
  final FavoriteRepository _favoriteRepository;

  GetFavoriteUsecase(this._favoriteRepository);

  Future<List<Product>> getFavorites(String token) async {
    return _favoriteRepository.getFavorites(token);
  }
}
