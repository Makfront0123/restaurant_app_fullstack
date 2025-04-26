import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/repository/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';

class GetCategoriesUseCase {
  final HomeRepository _homeRepository;
  GetCategoriesUseCase(this._homeRepository);
  Future<List<CategoryItem>> getCategories() async {
    return await _homeRepository.getCategories();
  }

  Future<List<CarouselItem>> getCarouselImages() async {
    return await _homeRepository.getCarouselImages();
  }
}
