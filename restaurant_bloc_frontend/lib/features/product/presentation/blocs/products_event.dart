
abstract class ProductsEvent {}

class LoadProductsData extends ProductsEvent {} 


class LoadProductsByCategory extends ProductsEvent {
  final String category;
  
  LoadProductsByCategory(this.category);

  List<Object> get props => [category];
}












/*
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
  @override
  List<Object> get props => [];
}

class LoadProductsData extends ProductsEvent {}
class ProductsInitial extends ProductsEvent {}



class LoadProductsByCategory extends ProductsEvent {
  final String category;
  
  const LoadProductsByCategory(this.category);

  @override
  List<Object> get props => [category];
}


 */