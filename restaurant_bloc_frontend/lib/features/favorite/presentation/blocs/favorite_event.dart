import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class FavoriteEvent {}

class FavoriteEventFavorite extends FavoriteEvent {
  final Product product;

  FavoriteEventFavorite({required this.product});
}

class FavoriteEventGetFavorite extends FavoriteEvent {
  final String token;

  FavoriteEventGetFavorite({required this.token});
}

class FavoriteEventUnfavorite extends FavoriteEvent {}
