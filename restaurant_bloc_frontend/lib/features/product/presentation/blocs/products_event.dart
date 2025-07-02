import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsData extends ProductsEvent {}

class LoadProduct extends ProductsEvent {
  final String productName;

  const LoadProduct(this.productName);

  @override
  List<Object> get props => [productName];
}

class LoadProductsByCategory extends ProductsEvent {
  final String category;

  const LoadProductsByCategory(this.category);

  @override
  List<Object> get props => [category];
}

