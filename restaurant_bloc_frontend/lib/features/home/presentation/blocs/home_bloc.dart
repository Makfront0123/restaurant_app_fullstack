import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/repositories/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_event.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc(this._homeRepository) : super(HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<CarouselPageChanged>(_onCarouselPageChanged);
  }
  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final images = await _homeRepository.getCarouselImages();
      final categories = await _homeRepository.getCategories();
      final reviews = await _homeRepository.getReviews();
      emit(HomeLoaded(
        images: images,
        currentPage: 0,
        categories: categories,
        reviews: reviews,
      ));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void _onCarouselPageChanged(
      CarouselPageChanged event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(currentPage: event.page));
    }
  }
}
