import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String imageUser;
  final bool accountVerified;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.imageUser,
    required this.accountVerified,
  });

  @override
  List<Object?> get props =>
      [id, name, email, role, imageUser, accountVerified];
}
