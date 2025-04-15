import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Category> categories;

  const MenuLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class MenuError extends MenuState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object> get props => [message];
}

/*

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<CategoryItem> categories;
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? currentCategoryFilter;

  MenuLoaded({
    required this.categories,
    required this.allProducts,
    required this.filteredProducts,
    this.currentCategoryFilter,
  });

  MenuLoaded copyWith({
    List<Product>? filteredProducts,
    String? currentCategoryFilter,
  }) {
    return MenuLoaded(
      categories: categories,
      allProducts: allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      currentCategoryFilter:
          currentCategoryFilter ?? this.currentCategoryFilter,
    );
  }
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);
}

 */