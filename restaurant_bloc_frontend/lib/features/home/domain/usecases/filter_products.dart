import 'package:restaurant_bloc_frontend/features/home/domain/repository/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class FilterProductsUseCase {
  final HomeRepository _homeRepository;
  FilterProductsUseCase(this._homeRepository);

  Future<List<Product>> call(String query, String category) async {
    return await _homeRepository.searchProducts(query, category);
  }
}
