import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}
