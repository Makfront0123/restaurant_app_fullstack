import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class ProductsState {}

//PRODUCTOS
class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductItem> products;
  ProductsLoaded(this.products);
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

///PRODUCTO
class ProductLoading extends ProductsState {}

class ProductLoaded extends ProductsState {
  final ProductItem product;
  ProductLoaded(this.product);
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
