import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends HomeEvent {}

class LoadHomeData extends HomeEvent {}

class CarouselPageChanged extends HomeEvent {
  final int page;
  const CarouselPageChanged(this.page);
  @override
  List<Object> get props => [page];
}
