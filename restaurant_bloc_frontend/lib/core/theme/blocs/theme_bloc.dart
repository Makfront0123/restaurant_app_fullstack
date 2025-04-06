import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_event.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_state.dart';
import 'package:restaurant_bloc_frontend/core/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppTheme.lightTheme())) {
    on<ToogleTheme>(_onToogleTheme);
  }

  Future<void> _onToogleTheme(
      ToogleTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeState(themeData: AppTheme.darkTheme()));
  }
}
