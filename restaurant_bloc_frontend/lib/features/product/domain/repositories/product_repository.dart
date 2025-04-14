import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product> getProduct(String name);
}
