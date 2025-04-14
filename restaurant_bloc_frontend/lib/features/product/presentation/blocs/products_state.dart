import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ProductsState extends Equatable {
  @override
  final List<Object> props = [];
}

// Productos

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsLoadedByCategory extends ProductsState {
  final List<Product> products;

  ProductsLoadedByCategory({required this.products});

  ProductsLoadedByCategory copyWith({List<Product>? products}) {
    return ProductsLoadedByCategory(
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [products];
}

// Producto individual

class ProductLoading extends ProductsState {}

class ProductLoaded extends ProductsState {
  final Product product;

  ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

// Error

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);

  @override
  List<Object> get props => [message];
}
