import 'package:restaurant_bloc_frontend/features/cart/domain/repositories/cart_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class RemoveProductFromCartUsecase {
  final CartRepository repository;

  RemoveProductFromCartUsecase(this.repository);

  Future<Product> call(String productId, String token) {
    return repository.removeFromCart(productId, token);
  }
}
