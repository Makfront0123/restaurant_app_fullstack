import 'package:restaurant_bloc_frontend/features/favorite/domain/entities/favorite_item.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/repository/favorite_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class AddFavoriteUsecase {
  final FavoriteRepository repository;

  AddFavoriteUsecase(this.repository);

  Future<Favorite> call(
      {required String token, required Product product}) async {
    return await repository.addFavorite(token, product);
  }
}
