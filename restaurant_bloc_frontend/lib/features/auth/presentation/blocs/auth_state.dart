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
