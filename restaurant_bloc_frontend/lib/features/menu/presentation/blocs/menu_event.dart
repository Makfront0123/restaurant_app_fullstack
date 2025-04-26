abstract class MenuEvent {}

class LoadCategories extends MenuEvent {}

class FilterCategories extends MenuEvent {
  final String filterCriteria;

  FilterCategories({required this.filterCriteria});
}
