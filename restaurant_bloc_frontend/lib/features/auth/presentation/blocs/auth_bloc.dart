import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/logout_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/register_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/verify_otp_user.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUser;
  final LoginUser _loginUser;
  final RegisterUser _registerUser;
  final VerifyOtpUser _verifyOtp;

  AuthBloc({
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required RegisterUser registerUser,
    required VerifyOtpUser verifyOtp,
  })  : _logoutUser = logoutUser,
        _loginUser = loginUser,
        _registerUser = registerUser,
        _verifyOtp = verifyOtp,
        super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RegisterEvent>(_onRegister);
    on<ResetAuthState>(_onReset);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(
        isLogged: false,
        isLoading: true,
        error: null,
      ));
      final user = await _loginUser(event.email, event.password);
      emit(state.copyWith(
          isLogged: true,
          isLoading: false,
          error: null,
          user: user,
          isVerify: user.accountVerified));
    } catch (e) {
      emit(state.copyWith(
          isLogged: false, isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLogged: false, isLoading: true, error: null));
      final user = await _registerUser(
          event.name, event.email, event.password, event.confirmPassword);
      emit(state.copyWith(
          isRegister: true, isLoading: false, error: null, user: user));
    } catch (e) {
      emit(state.copyWith(
          isLogged: false, isLoading: false, error: e.toString()));
    }
  }

  void _onReset(ResetAuthState event, Emitter<AuthState> emit) {
    emit(state.copyWith(isRegister: false, error: null));
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await _verifyOtp(event.otp, event.email);
      emit(state.copyWith(
          isLoading: false, error: null, isVerify: true, isLogged: false));
    } catch (e) {
      emit(state.copyWith(
          isLogged: false, isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _logoutUser();
      emit(state.copyWith(isLogged: false, user: null, error: null));
      print('Logout Success');
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
