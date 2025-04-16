import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/blocs/splash_event.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/blocs/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<ChangePageEvent>(_onChangePage);
  }

  void _onChangePage(ChangePageEvent event, Emitter<SplashState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }
}
