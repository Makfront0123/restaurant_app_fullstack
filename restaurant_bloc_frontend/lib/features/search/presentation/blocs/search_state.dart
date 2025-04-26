import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchCategoryListVisibleState extends SearchState {
  final List<CategoryItem> categories;
  SearchCategoryListVisibleState(this.categories);
}

class SearchResultState extends SearchState {
  final List<CategoryItem> matchedCategories;

  SearchResultState(this.matchedCategories);

  List<Object> get props => [matchedCategories];
}

class SearchSuccess extends SearchState {
  final List<Product> products;
  SearchSuccess(this.products);
}

class SearchCategoryListHiddenState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState(this.message);
}
