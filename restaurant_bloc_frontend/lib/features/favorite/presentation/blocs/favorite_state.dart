import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Product> products;

  FavoriteLoaded({required this.products});
}

class FavoritegetLoaded extends FavoriteState {
  final String token;
  final List<Product> products;

  FavoritegetLoaded({required this.token, required this.products});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}
