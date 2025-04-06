import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<CategoryItem> categories;
  final List<ProductItem> allProducts;
  final List<ProductItem> filteredProducts;
  final String? currentCategoryFilter;

  MenuLoaded({
    required this.categories,
    required this.allProducts,
    required this.filteredProducts,
    this.currentCategoryFilter,
  });

  MenuLoaded copyWith({
    List<ProductItem>? filteredProducts,
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
