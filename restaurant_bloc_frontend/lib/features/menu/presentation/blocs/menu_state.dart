import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';

// states/menu_state.dart
abstract class MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Category> categories;

  MenuLoaded(this.categories);
}

class MenuFiltered extends MenuState {
  final List<Category> filteredCategories;

  MenuFiltered(this.filteredCategories);
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);
}
