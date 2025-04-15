import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends MenuEvent {}

class LoadCategory extends MenuEvent {
  final String category;

  const LoadCategory(this.category);

  @override
  List<Object> get props => [category];
}

/*
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

 */