import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthRegistrationSuccess extends AuthState {
  final User user;

  const AuthRegistrationSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthVerificationSuccess extends AuthState {}

class AuthForgotPasswordSent extends AuthState {
  final String message;
  const AuthForgotPasswordSent(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthForgotSuccess extends AuthState {
  final String message;
  const AuthForgotSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;
  const AuthResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthForgotPasswordOtpSent extends AuthState {
  final String email;

  const AuthForgotPasswordOtpSent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthOtpVerifiedForReset extends AuthState {
  final String email;
  final String token;

  const AuthOtpVerifiedForReset({required this.email, required this.token});

  @override
  List<Object?> get props => [email, token];
}

class AuthOtpVerified extends AuthState {
  final String message;

  const AuthOtpVerified(this.message);

  @override
  List<Object?> get props => [message];
}




















/*

class AuthState extends Equatable {
  final bool isLogged;
  final bool isLoading;
  final String? error;
  final bool isRegister;
  final bool isVerify;
  final String? token;
  final User? user;
  final bool isForgot;
  final bool forgotSuccess;
  final String? message;
  final bool isReset;
  final bool isVerifyForgot;
  final bool isVerifyOtp;
  final bool isResendOtp;

  const AuthState({
    this.isResendOtp = false,
    this.isVerifyOtp = false,
    this.token,
    this.isForgot = false,
    this.isVerifyForgot = false,
    this.forgotSuccess = false,
    this.isLogged = false,
    this.isReset = false,
    this.isLoading = false,
    this.isRegister = false,
    this.isVerify = false,
    this.message,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isVerifyOtp,
    bool? isLogged,
    bool? isLoading,
    String? error,
    bool? isRegister,
    bool? isVerify,
    bool? isReset,
    bool? isForgot,
    bool? isVerifyForgot,
    User? user,
    String? token,
    bool? forgotSuccess,
    String? message,
    bool? isResendOtp,
  }) {
    return AuthState(
      isVerifyOtp: isVerifyOtp ?? this.isVerifyOtp,
      isLogged: isLogged ?? this.isLogged,
      isResendOtp: isResendOtp ?? this.isResendOtp,
      isLoading: isLoading ?? this.isLoading,
      isRegister: isRegister ?? this.isRegister,
      isReset: isReset ?? this.isReset,
      isForgot: isForgot ?? this.isForgot,
      isVerify: isVerify ?? this.isVerify,
      token: token ?? this.token,
      isVerifyForgot: isVerifyForgot ?? this.isVerifyForgot,
      error: error,
      user: user ?? this.user,
      forgotSuccess: forgotSuccess ?? this.forgotSuccess,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        isLogged,
        isLoading,
        isResendOtp,
        error,
        isVerifyOtp,
        user,
        isRegister,
        isVerify,
        message,
        isVerifyForgot,
        forgotSuccess,
        token,
        isReset
      ];
}

 */








/*

class AuthState extends Equatable {
  final bool isLogged;
  final bool isLoading;
  final String? error;
  final bool isRegister;
  final bool isVerify;
  final String? token;
  final User? user;
  final bool isForgot;
  final bool forgotSuccess;
  final String? message;
  final bool isReset;
  final bool isVerifyForgot;
  final bool isVerifyOtp;
  final bool isResendOtp;

  const AuthState({
    this.isResendOtp = false,
    this.isVerifyOtp = false,
    this.token,
    this.isForgot = false,
    this.isVerifyForgot = false,
    this.forgotSuccess = false,
    this.isLogged = false,
    this.isReset = false,
    this.isLoading = false,
    this.isRegister = false,
    this.isVerify = false,
    this.message,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isVerifyOtp,
    bool? isLogged,
    bool? isLoading,
    String? error,
    bool? isRegister,
    bool? isVerify,
    bool? isReset,
    bool? isForgot,
    bool? isVerifyForgot,
    User? user,
    String? token,
    bool? forgotSuccess,
    String? message,
    bool? isResendOtp,
  }) {
    return AuthState(
      isVerifyOtp: isVerifyOtp ?? this.isVerifyOtp,
      isLogged: isLogged ?? this.isLogged,
      isResendOtp: isResendOtp ?? this.isResendOtp,
      isLoading: isLoading ?? this.isLoading,
      isRegister: isRegister ?? this.isRegister,
      isReset: isReset ?? this.isReset,
      isForgot: isForgot ?? this.isForgot,
      isVerify: isVerify ?? this.isVerify,
      token: token ?? this.token,
      isVerifyForgot: isVerifyForgot ?? this.isVerifyForgot,
      error: error,
      user: user ?? this.user,
      forgotSuccess: forgotSuccess ?? this.forgotSuccess,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        isLogged,
        isLoading,
        isResendOtp,
        error,
        isVerifyOtp,
        user,
        isRegister,
        isVerify,
        message,
        isVerifyForgot,
        forgotSuccess,
        token,
        isReset
      ];
}

 */