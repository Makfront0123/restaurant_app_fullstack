import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ProductsRepository {
  Future<List<ProductItem>> getAllProducts() async {
    return _dummyProducts;
  }

  Future<List<ProductItem>> getProductsByCategory(String category) async {
    return _dummyProducts.where((product) => product.category == category).toList();
  }



  List<ProductItem> get _dummyProducts => [
    const ProductItem(
        image: Images.product01,
        productName: 'Caesar with Chicken',
        productPrice: 10.40,
        category: 'Salad',
        productWeight: 240),
    const ProductItem(
        image: Images.product03,
        productName: 'Burger Deluxe',
        productPrice: 5.40,
        category: 'Burguer',
        productWeight: 200),
     const ProductItem(
        image: Images.product02,
        productName: 'Beff Stroganoff',
        productPrice: 15.40,
        category: 'Meat',
        productWeight: 200),
         const ProductItem(
        image: Images.product04,
        productName: 'Fetuccinni Alla Puttanesca',
        productPrice: 15.40,
        category: 'Pasta',
        productWeight: 200),
  ];
}
