import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_state.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<ProductItem> _productsInCart = [];

  CartBloc() : super(CartInitial()) {
    on<AddProductToCart>((event, emit) async {
      _productsInCart.add(event.product);
      emit(CartUpdatedState(productsInCart: _productsInCart));
    });
    on<RemoveProductFromCart>((event, emit) async {
      _productsInCart.removeWhere(
          (product) => product.productName == event.product.productName);
      emit(CartUpdatedState(productsInCart: _productsInCart));
    });
  }
}
