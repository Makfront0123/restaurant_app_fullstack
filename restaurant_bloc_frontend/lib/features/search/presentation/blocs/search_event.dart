abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class SearchShowCategoryList extends SearchEvent {}

class SearchHideCategoryList extends SearchEvent {}
