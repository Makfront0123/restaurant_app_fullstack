abstract class MenuEvent {}

class LoadMenuLoad extends MenuEvent {}

class FilterProductByCategory extends MenuEvent {
  final String categoryId;
  FilterProductByCategory(this.categoryId);
}

class ClearProductFilter extends MenuEvent {}
