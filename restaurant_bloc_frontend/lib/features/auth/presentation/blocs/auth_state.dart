import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

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
