import 'package:restaurant_bloc_frontend/features/cart/domain/repositories/cart_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class GetCartUsecase {
  final CartRepository repository;

  GetCartUsecase(this.repository);

  Future<List<Product>> call(String token) async {
    final cartItems = await repository.getCart(token);
    return cartItems.map((item) {
      final product = item.product;
      product.productCount = item.quantity;
      return product;
    }).toList();
  }
}
