import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_event.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState());

  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FavoriteEventFavorite) {
      yield FavoriteState(isFavorite: true);
    } else if (event is FavoriteEventUnfavorite) {
      yield FavoriteState(isFavorite: false);
    }
  }
}