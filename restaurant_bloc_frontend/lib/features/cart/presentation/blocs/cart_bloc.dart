import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/usecases/add_product.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/usecases/get_cart.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/usecases/remove_product.dart';

import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<Product> _productsInCart = [];
  final AddCartUsecase _addProductToCart;
  final RemoveProductFromCartUsecase _removeProductFromCart;
  final GetCartUsecase _getCart;

  CartBloc({
    required GetCartUsecase getCart,
    required AddCartUsecase addProductToCart,
    required RemoveProductFromCartUsecase removeProductFromCart,
  })  : _addProductToCart = addProductToCart,
        _removeProductFromCart = removeProductFromCart,
        _getCart = getCart,
        super(CartInitial()) {
    on<AddProductToCart>(_onAddProduct);
    on<RemoveProductFromCart>(_onRemoveProduct);
    on<GetCart>(_onGetCart);
    on<UpdateProductCount>(_onUpdateProductCount);
  }

  void _onGetCart(GetCart event, Emitter<CartState> emit) async {
    try {
      final token = event.token;

      if (token.isEmpty) {
        emit(CartErrorState(message: 'Token vacío'));
        return;
      }

      final cart = await _getCart(token);

      if (cart.isNotEmpty) {
        emit(CartUpdatedState(productsInCart: cart));
      } else {
        emit(CartErrorState(message: 'El carrito está vacío'));
      }
    } catch (e) {
      emit(CartErrorState(message: 'Error al obtener el carrito: $e'));
    }
  }

  void _onAddProduct(AddProductToCart event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final index = _productsInCart.indexWhere(
      (item) => item.productName == event.product.productName,
    );

    if (index != -1) {
      _productsInCart[index].productCount++;
    } else {
      _productsInCart.add(event.product..productCount = 1);
    }

    final product = _productsInCart.firstWhere(
      (item) => item.productName == event.product.productName,
    );

    final cartItem = CartItem(product: product, quantity: product.productCount);

    try {
      await _addProductToCart(cartItem, token ?? '');
      emit(CartUpdatedState(productsInCart: List.from(_productsInCart)));
    } catch (e) {
      emit(CartErrorState(message: 'Error al agregar al carrito'));
    }
  }

  void _onRemoveProduct(
      RemoveProductFromCart event, Emitter<CartState> emit) async {
    _productsInCart.removeWhere((item) => item.id == event.product.id);

    try {
      await _removeProductFromCart(event.product.id, event.token);
      final cart = await _getCart(event.token);
      emit(CartUpdatedState(productsInCart: cart));
    } catch (e) {
      emit(CartErrorState(message: 'Error al eliminar del carrito'));
    }
  }

  void _onUpdateProductCount(
    UpdateProductCount event,
    Emitter<CartState> emit,
  ) async {
    final currentState = state;

    if (currentState is CartUpdatedState) {
      final updatedProducts = currentState.productsInCart.map((product) {
        if (product.id == event.product.id) {
          return product.copyWith(productCount: event.count);
        }
        return product;
      }).toList();

      emit(CartUpdatedState(productsInCart: updatedProducts));
    }
  }
}
