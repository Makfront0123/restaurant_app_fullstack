import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class ResetAuthState extends AuthEvent {}

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
