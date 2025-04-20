import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/forgot_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/logout_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/register_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/resend_otp_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/resend_otp_forgot.dart';
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
  final ResendOtpForgot _resendOtpForgot;

  AuthBloc({
    required ResendOtp resendOtp,
    required ForgotAuth forgotPassword,
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required ResendOtpForgot resendOtpForgot,
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
        _resendOtpForgot = resendOtpForgot,
        _resetPassword = resetPassword,
        super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RegisterEvent>(_onRegister);
    on<ResetAuthState>((_, emit) => emit(AuthInitial()));
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ForgotEvent>(_onForgot);
    on<ResetPasswordEvent>(_onResetPassword);
    on<VerifyForgotEvent>(_onVerifyForgot);
    on<ResendOtpEvent>(_onResendOtp);
    on<ResendOtpForgotEvent>(_onResendOtpForgot);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _loginUser(event.email, event.password);
      if (user.accountVerified) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthVerificationSuccess());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await _registerUser(
        event.name,
        event.email,
        event.password,
        event.confirmPassword,
      );
      emit(AuthRegistrationSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final message = await _verifyOtp(event.otp, event.email);
      emit(AuthOtpVerified(message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgot(ForgotEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await _forgotPassword(event.email);
      emit(AuthForgotSuccess(res['message'], event.email));
      emit(AuthForgotPasswordOtpSent(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyForgot(
      VerifyForgotEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await _verifyForgot(event.otp, event.email);

      final token = res['data']['token'];
      emit(AuthOtpVerifiedForReset(
        email: event.email,
        token: token,
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _resetPassword(
          event.email, event.token, event.password, event.newPassword);
      emit(AuthResetPasswordSuccess(response['message']));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResendOtp(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _resendOtp(event.email);
      emit(
          AuthVerificationSuccess()); // O crea AuthOtpResent(message) si quieres mostrar feedback
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResendOtpForgot(
      ResendOtpForgotEvent event, Emitter<AuthState> emit) async {
    try {
      await _resendOtpForgot(event.email);
      emit(AuthForgotPasswordOtpSent(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _logoutUser();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
