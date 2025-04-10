import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/repositories/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
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

    final allCategories = await repository.getCategories();
    final filtered = allCategories
        .where((cat) => cat.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(SearchCategoryListVisibleState(filtered));
  }

  Future<void> _onSearchHideCategoryList(
      SearchHideCategoryList event, Emitter<SearchState> emit) async {
    emit(SearchCategoryListHiddenState());
  }
}
