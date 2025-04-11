import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<ProductItem> _productsInCart = [];

  CartBloc() : super(CartInitial()) {
    on<AddProductToCart>(_onAddProduct);
    on<RemoveProductFromCart>(_onRemoveProduct);
    on<IncrementProductCount>(_onIncrementCount);
    on<DecrementProductCount>(_onDecrementCount);
  }

  void _onAddProduct(AddProductToCart event, Emitter<CartState> emit) {
    final index = _productsInCart
        .indexWhere((item) => item.productName == event.product.productName);

    if (index != -1) {
      _productsInCart[index].productCount++;
    } else {
      _productsInCart.add(event.product..productCount = 1);
    }

    emit(CartUpdatedState(productsInCart: List.from(_productsInCart)));
  }

  void _onRemoveProduct(RemoveProductFromCart event, Emitter<CartState> emit) {
    _productsInCart
        .removeWhere((item) => item.productName == event.product.productName);
    emit(CartUpdatedState(productsInCart: List.from(_productsInCart)));
  }

  void _onIncrementCount(IncrementProductCount event, Emitter<CartState> emit) {
    final index = _productsInCart
        .indexWhere((item) => item.productName == event.product.productName);

    if (index != -1) {
      _productsInCart[index].productCount++;
      emit(CartUpdatedState(productsInCart: List.from(_productsInCart)));
    }
  }

  void _onDecrementCount(DecrementProductCount event, Emitter<CartState> emit) {
    final index = _productsInCart
        .indexWhere((item) => item.productName == event.product.productName);

    if (index != -1 && _productsInCart[index].productCount > 1) {
      _productsInCart[index].productCount--;
      emit(CartUpdatedState(productsInCart: List.from(_productsInCart)));
    }
  }
}
