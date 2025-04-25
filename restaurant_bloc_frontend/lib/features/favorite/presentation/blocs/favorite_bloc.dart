import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/usecases/add_favorite.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/usecases/get_favorite.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_event.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final AddFavoriteUsecase _addFavorite;
  final GetFavoriteUsecase _getFavorite;
  FavoriteBloc({
    required AddFavoriteUsecase addFavorite,
    required GetFavoriteUsecase getFavorite,
  })  : _addFavorite = addFavorite,
        _getFavorite = getFavorite,
        super(FavoriteInitial()) {
    on<FavoriteEventFavorite>(_onAddFavorite);
    on<FavoriteEventGetFavorite>(_onGetFavorite);
  }
  void _onAddFavorite(
      FavoriteEventFavorite event, Emitter<FavoriteState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    emit(FavoriteLoading());
    try {
      await _addFavorite(
        product: event.product,
        token: token!,
      );

      emit(FavoriteLoaded(products: [event.product]));
    } catch (e) {
      emit(FavoriteError(message: 'Error al agregar al favorito'));
    }
  }

  void _onGetFavorite(
      FavoriteEventGetFavorite event, Emitter<FavoriteState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        emit(FavoriteError(message: 'Token no encontrado'));
        return;
      }

      emit(FavoriteLoading());

      final favorites = await _getFavorite.getFavorites(token);
      if (favorites.isEmpty) {
        emit(FavoritegetLoaded(
          token: token,
          products: [],
        ));
      }

      // Siempre emitimos `FavoritegetLoaded` incluso si está vacío
      emit(FavoritegetLoaded(
        token: token,
        products: favorites,
      ));
    } catch (e) {
      // Solo emitimos error si es una excepción real que no se puede recuperar
      emit(FavoriteError(message: e.toString()));
    }
  }
}
