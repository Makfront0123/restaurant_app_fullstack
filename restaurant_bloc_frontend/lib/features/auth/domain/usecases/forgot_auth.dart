import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class ForgotAuth {
  final AuthRepository repository;

  ForgotAuth(this.repository);

  Future<Map<String, dynamic>> call(String email) {
    return repository.forgotPassword(email);
  }
}
