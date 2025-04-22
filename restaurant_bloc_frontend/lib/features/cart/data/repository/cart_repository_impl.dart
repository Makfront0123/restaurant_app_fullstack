import 'package:restaurant_bloc_frontend/features/cart/data/datasources/remote/cart_api_services.dart';

import 'package:restaurant_bloc_frontend/features/cart/domain/entities/cart.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/repositories/cart_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class CartRepositoryImpl implements CartRepository {
  final CartApiServices cartApiServices;

  CartRepositoryImpl(this.cartApiServices);

  @override
  Future<Product> addToCart(CartItem item, String token) async {
    final productModel = await cartApiServices.addToCart(item, token);
    return productModel.toProduct();
  }

  @override
  Future<Product> removeFromCart(String productId, String token) async {
    final productModel =
        await cartApiServices.deleteProductFromCart(productId, token);
    return productModel.toProduct();
  }

  @override
  Future<void> clearCart() async {
    await cartApiServices.clearCart();
  }

  @override
  Future<List<CartItem>> getCart(String token) async {
    final cart = await cartApiServices.getCart(token);
    return cart;
  }
}
