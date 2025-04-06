import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ProductsRepository {
  Future<List<ProductItem>> getAllProducts() async {
    return _dummyProducts;
  }

  Future<List<ProductItem>> getProductsByCategory(String category) async {
    return _dummyProducts
        .where((product) => product.category == category)
        .toList();
  }

  Future<ProductItem> getProduct(String productName) async {
    return _dummyProducts
        .firstWhere((product) => product.productName == productName);
  }

  List<ProductItem> get _dummyProducts => [
        const ProductItem(
            image: Images.product01,
            productName: 'Caesar with Chicken',
            productPrice: 10.40,
            kcal: 140,
            productDescription:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            category: 'Salad',
            productWeight: 240),
        const ProductItem(
            image: Images.product03,
            productName: 'Burger Deluxe',
            productPrice: 5.40,
            productDescription:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            kcal: 140,
            category: 'Burguer',
            productWeight: 200),
        const ProductItem(
            image: Images.product02,
            productName: 'Beff Stroganoff',
            productPrice: 15.40,
            productDescription:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            kcal: 140,
            category: 'Meat',
            productWeight: 200),
        const ProductItem(
            image: Images.product04,
            productName: 'Fetuccinni Alla Puttanesca',
            productPrice: 15.40,
            productDescription:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            kcal: 140,
            category: 'Pasta',
            productWeight: 200),
      ];
}
