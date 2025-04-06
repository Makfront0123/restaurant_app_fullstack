import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/data/repositories/product_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _productRepository;

  ProductsBloc(this._productRepository) : super(ProductsInitial()) {
    on<LoadProductsData>(_onLoadProductsData);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<LoadProduct>(_onLoadProduct);
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

  Future<void> _onLoadProduct(
      LoadProduct event, Emitter<ProductsState> emit) async {
    emit(ProductLoading());
    try {
      final product = await _productRepository.getProduct(event.productName);
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductsError('Error loading product: $e'));
    }
  }
}
