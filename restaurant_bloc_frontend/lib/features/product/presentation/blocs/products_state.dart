import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductItem> products;
  ProductsLoaded(this.products);
}

class ProductLoaded extends ProductsState {
  final ProductItem product;
  ProductLoaded(this.product);
}

class ProductsLoadedByCategory extends ProductsState {
  final List<ProductItem> products;
  ProductsLoadedByCategory({
    required this.products,
  });
  ProductsLoadedByCategory copyWith({List<ProductItem>? products}) {
    return ProductsLoadedByCategory(
      products: products ?? this.products,
    );
  }

  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}