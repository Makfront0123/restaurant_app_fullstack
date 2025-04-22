import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/repositories/cart_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class AddCartUsecase {
  final CartRepository repository;
  AddCartUsecase(this.repository);

  Future<Product> call(CartItem cartItems, String token) async {
    return await repository.addToCart(cartItems, token);
  }
}
