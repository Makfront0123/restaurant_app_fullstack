import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/review_item.dart';

class HomeRepository {
  Future<List<CarouselItem>> getCarouselImages() async {
    return [
      const CarouselItem(image: Images.carousel01),
      const CarouselItem(image: Images.carousel01),
      const CarouselItem(image: Images.carousel01)
    ];
  }

  Future<List<CategoryItem>> getCategories() async {
    return [
      const CategoryItem(image: Images.product01, title: 'Salad'),
      const CategoryItem(image: Images.product03, title: 'Burguer'),
      const CategoryItem(image: Images.product04, title: 'Pasta'),
      const CategoryItem(image: Images.product02, title: 'Meat'),
    ];
  }

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
