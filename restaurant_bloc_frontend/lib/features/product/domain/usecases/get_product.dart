import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/repositories/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Product> call(String name) {
    return repository.getProduct(name);
  }
}
