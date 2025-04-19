import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterEvent({
    required this.confirmPassword,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String email;
  const VerifyOtpEvent({required this.otp, required this.email});
  @override
  List<Object?> get props => [otp, email];
}

class ForgotEvent extends AuthEvent {
  final String email;

  const ForgotEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResetPasswordEvent extends AuthEvent {
  final String token;
  final String email;
  final String password;
  final String newPassword;

  const ResetPasswordEvent({
    required this.email,
    required this.token,
    required this.password,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [token, password, newPassword, email];
}

class ResetAuthState extends AuthEvent {}

class ResendOtpEvent extends AuthEvent {
  final String email;

  const ResendOtpEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResendOtpForgotEvent extends AuthEvent {
  final String email;

  const ResendOtpForgotEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyForgotEvent extends AuthEvent {
  final String email;
  final String otp;

  const VerifyForgotEvent({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
