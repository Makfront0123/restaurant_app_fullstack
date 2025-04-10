import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchCategoryListVisibleState extends SearchState {
  final List<CategoryItem> categories;
  SearchCategoryListVisibleState(this.categories);
}

class SearchCategoryListHiddenState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState(this.message);
}
