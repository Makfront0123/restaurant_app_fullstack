import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/datasources/home_api_services.dart';

import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeApiServices productApiServices;

  SearchBloc(this.productApiServices) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchHideCategoryList>(_onSearchHideCategoryList);
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchCategoryListHiddenState());
      return;
    }

    try {
      // Llamamos al servicio para buscar productos
      final products = await productApiServices.searchProducts(query);
      emit(SearchCategoryListVisibleState(products));
    } catch (e) {
      emit(SearchCategoryListHiddenState());
    }
  }

  Future<void> _onSearchHideCategoryList(
      SearchHideCategoryList event, Emitter<SearchState> emit) async {
    emit(SearchCategoryListHiddenState());
  }
}
