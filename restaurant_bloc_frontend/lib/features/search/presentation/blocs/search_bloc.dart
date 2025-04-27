import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/usecases/filter_products.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FilterProductsUseCase _filterProducts;

  SearchBloc({
    required FilterProductsUseCase filterProducts,
  })  : _filterProducts = filterProducts,
        super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchHideCategoryList>(_onSearchHideCategoryList);
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchCategoryListHiddenState([], showSidebar: false));
    } else {
      final filteredProducts =
          await _filterProducts(event.query, event.category);
      if (filteredProducts.isEmpty) {
        emit(SearchNoResultsState([], showSidebar: true));
      } else {
        emit(SearchCategoryListVisibleState(
          filteredProducts,
          showSidebar: true,
        ));
      }
    }
  }

  Future<void> _onSearchHideCategoryList(
      SearchHideCategoryList event, Emitter<SearchState> emit) async {
    emit(SearchCategoryListHiddenState([], showSidebar: false));
  }
}
