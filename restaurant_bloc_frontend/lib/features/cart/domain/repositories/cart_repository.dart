import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class CartRepository {
  Future<Product> addToCart(CartItem item, String token);
  Future<Product> removeFromCart(String productId, String token);

  Future<void> clearCart();

  Future<List<CartItem>> getCart(String token);
}
