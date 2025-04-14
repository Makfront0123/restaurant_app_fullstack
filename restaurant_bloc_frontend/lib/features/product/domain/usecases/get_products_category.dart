import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<List<Product>> call(String category) {
    return repository.getProductsByCategory(category);
  }
}
