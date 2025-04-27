import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/home/data/datasources/home_api_services.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';

import 'package:restaurant_bloc_frontend/features/home/domain/repository/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiServices _homeApiServices;
  HomeRepositoryImpl(this._homeApiServices);

  @override
  Future<List<CategoryItem>> getCategories() async {
    return await _homeApiServices.getCategories();
  }

  @override
  Future<List<CarouselItem>> getCarouselImages() async {
    return [
      const CarouselItem(image: Images.carousel01),
      const CarouselItem(image: Images.carousel01),
      const CarouselItem(image: Images.carousel01)
    ];
  }

  @override
  Future<List<Product>> searchProducts(String query, String category) async {
    final response = await _homeApiServices.searchProducts(query, category);

    final dataList = response['data'] as List<dynamic>;

    return dataList.map((json) => Product.fromJson(json)).toList();
  }
}
