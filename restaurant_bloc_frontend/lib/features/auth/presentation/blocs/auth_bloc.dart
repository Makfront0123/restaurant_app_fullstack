import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/logout_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUser;
  final LoginUser _loginUser;

  AuthBloc({
    required LoginUser loginUser,
    required LogoutUser logoutUser,
  })  : _logoutUser = logoutUser,
        _loginUser = loginUser,
        super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLogged: false, isLoading: true, error: null));
      final user = await _loginUser(event.email, event.password);
      emit(state.copyWith(
          isLogged: true, isLoading: false, error: null, user: user));
    } catch (e) {
      emit(state.copyWith(
          isLogged: false, isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _logoutUser();
      emit(state.copyWith(isLogged: false, user: null, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
