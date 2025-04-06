import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/data/repositories/product_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _productRepository;

  ProductsBloc(this._productRepository) : super(ProductsInitial()) {
    on<LoadProductsData>(_onLoadProductsData);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }

  Future<void> _onLoadProductsData(
    LoadProductsData event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading()); 
    try {
      final products = await _productRepository.getAllProducts();
      if (products.isEmpty) {
        emit(ProductsError('Error al cargar: No hay productos')); 
      } else {
        emit(ProductsLoaded(
          products,
        )); 
      }
    } catch (e) {
      emit(ProductsError(e.toString())); 
    }
  }

  Future<void> _onLoadProductsByCategory(
      LoadProductsByCategory event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products =
          await _productRepository.getProductsByCategory(event.category);
      emit(ProductsLoadedByCategory(products: products));
    } catch (e) {
      emit(ProductsError('Error loading products for category: $e'));
    }
  }
}
  /*
  class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _productRepository;
  ProductsBloc(this._productRepository) : super(ProductsLoading()) {
    on<LoadProductsData>(_onLoadProductsData);
    ///on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }
   Future<void> _onLoadProductsData(
    LoadProductsData event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading()); // Estado de carga
    try {
      final products = await _repository.getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

   */

  /*
  Future<void> _onLoadProductsByCategory(
      LoadProductsByCategory event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products =
          await _productRepository.getProductsByCategory(event.category);
      emit(ProductsLoadedByCategory(products: products));
    } catch (e) {
      emit(ProductsError(message: 'Error loading products for category: $e'));
    }
  }
   */
