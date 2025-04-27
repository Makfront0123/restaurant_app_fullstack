import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/usecases/get_all_categories.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_event.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetAllCategories _getAllCategories;
  List<Category> _allCategories = [];

  MenuBloc({
    required GetAllCategories getAllCategories,
  })  : _getAllCategories = getAllCategories,
        super(MenuLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<MenuState> emit,
  ) async {
    emit(MenuLoading());
    try {
      final categories = await _getAllCategories();
      _allCategories = categories;
      emit(MenuLoaded(categories));
    } catch (e) {
      emit(MenuError('Error loading categories: $e'));
    }
  }

  void _onFilterCategories(
    FilterCategories event,
    Emitter<MenuState> emit,
  ) {
    try {
      final filteredCategories = _allCategories
          .where((category) => category.title.contains(event.filterCriteria))
          .toList();

      emit(MenuFiltered(filteredCategories));
    } catch (e) {
      emit(MenuError('Error filtering categories: $e'));
    }
  }
}
