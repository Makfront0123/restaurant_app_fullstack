abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
}

class RegisterEvent extends AuthEvent {
}

class LogoutEvent extends AuthEvent {}
