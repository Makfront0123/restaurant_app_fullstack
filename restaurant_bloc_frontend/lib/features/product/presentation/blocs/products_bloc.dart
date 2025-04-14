import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_all_products.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_product.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_products_category.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProducts _getAllProducts;
  final GetProduct _getProduct;
  final GetProductsByCategory _getProductsByCategory;

  ProductsBloc({
    required GetAllProducts getAllProducts,
    required GetProduct getProduct,
    required GetProductsByCategory getProductsByCategory,
  })  : _getAllProducts = getAllProducts,
        _getProduct = getProduct,
        _getProductsByCategory = getProductsByCategory,
        super(ProductsInitial()) {
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
      final products = await _getAllProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError('Error loading products: $e'));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final products = await _getProductsByCategory(event.category);
      emit(ProductsLoadedByCategory(products: products));
    } catch (e) {
      emit(ProductsError('Error loading products for category: $e'));
    }
  }

  Future<void> _onLoadProduct(
    LoadProduct event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final product = await _getProduct(event.productName);
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductsError('Error loading product: $e'));
    }
  }
}
