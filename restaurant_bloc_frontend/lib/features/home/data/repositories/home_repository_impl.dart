import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/home/data/datasources/home_api_services.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/review_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/repository/home_repository.dart';

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
  Future<List<ReviewItem>> getReviews() async {
    return [
      ReviewItem(
          review:
              'Absolute love your food, the flavoors were so vibrant and the presentation was top-notch. Cant wait to try it out again.',
          author: 'John Doe',
          imageUser: Images.user,
          date: DateTime.now()),
      ReviewItem(
          review:
              'Absolute love your food, the flavoors were so vibrant and the presentation was top-notch. Cant wait to try it out again.',
          author: 'John Doe',
          imageUser: Images.user,
          date: DateTime.now()),
      ReviewItem(
          review:
              'Absolute love your food, the flavoors were so vibrant and the presentation was top-notch. Cant wait to try it out again.',
          author: 'John Doe',
          imageUser: Images.user,
          date: DateTime.now()),
      ReviewItem(
          review:
              'Absolute love your food, the flavoors were so vibrant and the presentation was top-notch. Cant wait to try it out again.',
          author: 'John Doe',
          imageUser: Images.user,
          date: DateTime.now()),
    ];
  }
}
