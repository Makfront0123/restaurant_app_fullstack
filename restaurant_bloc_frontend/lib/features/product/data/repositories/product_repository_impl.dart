import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/product/data/datasources/remote/product_api_services.dart';
import 'package:restaurant_bloc_frontend/features/product/data/models/product_model.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiServices read;
  ProductRepositoryImpl(this.read);

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await read.getAllProducts();

    return (response['data'] as List)
        .map((e) => ProductModel.fromJson(e).toProduct())
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await read.getProductsByCategory(category);

    if (response is Map && response.containsKey('data')) {
      final products = (response['data'] as List)
          .map((item) => ProductModel.fromJson(item).toProduct())
          .toList();

      return products;
    } else {
      throw Exception('Respuesta inesperada: $response');
    }
  }

  @override
  Future<Product> getProduct(String name) async {
    return Product(
      id: '1',
      productName: 'Caesar with Chicken',
      productPrice: 10.40,
      kcal: 140,
      productDescription:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      category: 'Salad',
      productWeight: 240,
      image: Images.product01,
    );
  }
}
