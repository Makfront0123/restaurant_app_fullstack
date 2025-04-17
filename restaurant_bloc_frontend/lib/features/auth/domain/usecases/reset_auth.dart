import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class ResetAuth {
  final AuthRepository repository;

  ResetAuth(this.repository);

  Future<Map<String, dynamic>> call(
    String email,
    String token,
    String password,
    String newPassword,
  ) {
    return repository.resetPassword(
      email,
      token,
      password,
      newPassword,
    );
  }
}
