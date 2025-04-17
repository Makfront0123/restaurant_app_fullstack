import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/models/user_model.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/forgot_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/logout_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/register_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/resend_otp_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/reset_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/verify_forgot.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/verify_otp_user.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUser;
  final LoginUser _loginUser;
  final RegisterUser _registerUser;
  final VerifyAccount _verifyOtp;
  final ForgotAuth _forgotPassword;
  final ResetAuth _resetPassword;
  final VerifyForgot _verifyForgot;
  final ResendOtp _resendOtp;

  AuthBloc({
    required ResendOtp resendOtp,
    required ForgotAuth forgotPassword,
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required VerifyForgot verifyForgot,
    required RegisterUser registerUser,
    required VerifyAccount verifyOtp,
    required ResetAuth resetPassword,
  })  : _logoutUser = logoutUser,
        _loginUser = loginUser,
        _registerUser = registerUser,
        _verifyOtp = verifyOtp,
        _verifyForgot = verifyForgot,
        _resendOtp = resendOtp,
        _forgotPassword = forgotPassword,
        _resetPassword = resetPassword,
        super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RegisterEvent>(_onRegister);
    on<ResetAuthState>(_onReset);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ForgotEvent>(_onForgot);
    on<ResetPasswordEvent>(_onResetPassword);
    on<VerifyForgotEvent>(_onVerifyForgot);
    on<ResendOtpEvent>(_onResendOtp);
  }
  Future<void> _onVerifyForgot(
      VerifyForgotEvent event, Emitter<AuthState> emit) async {
    try {
      final res = await _verifyForgot(event.otp, event.email);

      final user = UserModel.fromJson(res['data']['user']);
      final token = res['data']['token'];

      emit(state.copyWith(
        isLoading: false,
        isVerifyForgot: true,
        error: null,
        user: user,
        token: token,
        message: res['message'],
      ));
    } catch (e) {
      emit(state.copyWith(
          isLogged: false, isLoading: false, error: e.toString()));
    }
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
      ///emit(state.copyWith(isLogged: false, isLoading: true, error: null));
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
    emit(state.copyWith(
      isRegister: false,
      isForgot: false,
      forgotSuccess: false,
      error: null,
    ));
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await _resetPassword(
        event.email,
        event.token,
        event.password,
        event.newPassword,
      );

      final message =
          response['message'] as String? ?? 'Unexpected error occurred';

      emit(state.copyWith(
        isLoading: false,
        isReset: true,
        error: null,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
          isLogged: false, isLoading: false, error: e.toString()));
    }
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
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onForgot(ForgotEvent event, Emitter<AuthState> emit) async {
    try {
      final res = await _forgotPassword(event.email);

      final user = UserModel.fromJson(res['data']['user']);

      emit(state.copyWith(
        isLoading: false,
        isForgot: true,
        forgotSuccess: true,
        error: null,
        message: res['message'],
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onResendOtp(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await _resendOtp(event.email);

      final message =
          response['message'] as String? ?? 'Unexpected error occurred';

      emit(state.copyWith(
        isLoading: false,
        isResendOtp: true,
        error: null,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLogged: false,
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
/*

  Future<void> _onForgot(ForgotEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await _forgotPassword(event.email);

      final message =
          response['message'] as String? ?? 'Unexpected error occurred';

      emit(state.copyWith(
        isLoading: false,
        isForgot: true,
        forgotSuccess: true,
        error: null,
        message: message,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isForgot: true,
        forgotSuccess: false,
        error: e.toString(),
      ));
    }
  }
 */