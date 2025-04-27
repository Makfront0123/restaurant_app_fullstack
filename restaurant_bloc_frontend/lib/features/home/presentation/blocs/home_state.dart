import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/review_item.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CarouselItem> images;
  final int currentPage;
  final List<CategoryItem> categories;

  const HomeLoaded({
    required this.images,
    this.currentPage = 0,
    required this.categories,
  });

  HomeLoaded copyWith({
    List<CarouselItem>? images,
    int? currentPage,
    List<CategoryItem>? categories,
    List<ReviewItem>? reviews,
  }) {
    return HomeLoaded(
      images: images ?? this.images,
      currentPage: currentPage ?? this.currentPage,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [
        images,
        currentPage,
        categories,
      ];
}

class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
  @override
  List<Object> get props => [message];
}
