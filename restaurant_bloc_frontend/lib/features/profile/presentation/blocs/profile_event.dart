import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final String username;
  final String confirmPassword;
  final String password;
  final String token;

  UpdateProfileEvent(
      {required this.username,
      required this.confirmPassword,
      required this.password,
      required this.token});

  @override
  List<Object?> get props => [username, confirmPassword, password, token];
}
