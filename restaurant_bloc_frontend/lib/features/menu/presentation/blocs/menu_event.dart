class MenuEvent {}

class LoadMenuData extends MenuEvent {}

class LoadMenuDataSuccess extends MenuEvent {
  final List<String> menu;

  LoadMenuDataSuccess(this.menu);
}

class LoadMenuDataFailure extends MenuEvent {
  final String message;

  LoadMenuDataFailure(this.message);
}

class MenuCategoryEvent extends MenuEvent {
  final String category;

  MenuCategoryEvent(this.category);
}
