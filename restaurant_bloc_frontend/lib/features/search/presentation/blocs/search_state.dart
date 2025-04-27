import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchCategoryListVisibleState extends SearchState {
  final List<Product> products;
  final bool? showSidebar;
  SearchCategoryListVisibleState(this.products, {this.showSidebar = true});
}

class SearchNoResultsState extends SearchState {
  final List<Product> products;
  final bool? showSidebar;
  SearchNoResultsState(this.products, {this.showSidebar = true});
}

class SearchCategoryListHiddenState extends SearchState {
  final List<Product> products;
  final bool? showSidebar;
  SearchCategoryListHiddenState(this.products, {this.showSidebar = false});
}

class SearchResultState extends SearchState {
  final List<Product> matchedCategories;

  SearchResultState(this.matchedCategories);

  List<Object> get props => [matchedCategories];
}

class SearchSuccess extends SearchState {
  final List<Product> products;
  SearchSuccess(this.products);
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState(this.message);
}
