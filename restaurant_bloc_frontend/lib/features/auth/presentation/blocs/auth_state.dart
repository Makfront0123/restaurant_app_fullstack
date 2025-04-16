import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

class AuthState extends Equatable {
  final bool isLogged;
  final bool isLoading;
  final String? error;
  final bool isRegister;
  final bool isVerify;
  final User? user;
  final bool isForgot;

  const AuthState({
    this.isForgot = false,
    this.isLogged = false,
    this.isLoading = false,
    this.isRegister = false,
    this.isVerify = false,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isLogged,
    bool? isLoading,
    String? error,
    bool? isRegister,
    bool? isVerify,
    bool? isForgot,
    User? user,
  }) {
    return AuthState(
      isLogged: isLogged ?? this.isLogged,
      isLoading: isLoading ?? this.isLoading,
      isRegister: isRegister ?? this.isRegister,
      isForgot: isForgot ?? this.isForgot,
      isVerify: isVerify ?? this.isVerify,
      error: error,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props =>
      [isLogged, isLoading, error, user, isRegister, isVerify];
}
