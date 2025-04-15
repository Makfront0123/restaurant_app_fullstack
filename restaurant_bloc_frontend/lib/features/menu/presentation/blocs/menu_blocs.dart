import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/repositories/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/usecases/get_all_categories.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_event.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetAllCategories _getAllCategories;

  MenuBloc({
    required GetAllCategories getAllCategories,
  })  : _getAllCategories = getAllCategories,
        super(MenuInitial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<MenuState> emit,
  ) async {
    emit(MenuLoading());
    try {
      final categories = await _getAllCategories();
      emit(MenuLoaded(categories));
    } catch (e) {
      emit(MenuError('Error loading categories: $e'));
    }
  }
}
