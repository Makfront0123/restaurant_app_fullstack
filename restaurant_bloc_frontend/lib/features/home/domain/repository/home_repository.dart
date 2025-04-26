import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/review_item.dart';

abstract class HomeRepository {
  Future<List<CarouselItem>> getCarouselImages();
  Future<List<CategoryItem>> getCategories();
  Future<List<ReviewItem>> getReviews();
}
