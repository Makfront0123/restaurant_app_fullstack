abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  final String category;
  SearchQueryChanged(this.query, this.category);
}

class SearchShowCategoryList extends SearchEvent {}

class SearchHideCategoryList extends SearchEvent {}
