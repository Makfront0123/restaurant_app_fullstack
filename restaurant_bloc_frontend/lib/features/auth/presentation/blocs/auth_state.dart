import 'package:equatable/equatable.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

class AuthState extends Equatable {
  final bool isLogged;
  final bool isLoading;
  final String? error;
  final bool isRegister;
  final bool isVerify;
  final User? user;

  const AuthState({
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
    User? user,
  }) {
    return AuthState(
      isLogged: isLogged ?? this.isLogged,
      isLoading: isLoading ?? this.isLoading,
      isRegister: isRegister ?? this.isRegister,
      isVerify: isVerify ?? this.isVerify,
      error: error,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props =>
      [isLogged, isLoading, error, user, isRegister, isVerify];
}
