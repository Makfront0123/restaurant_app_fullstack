import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/repositories/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_event.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final HomeRepository repository;

  MenuBloc(this.repository) : super(MenuLoading());
}
