import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class ForgotAuth {
  final AuthRepository repository;

  ForgotAuth(this.repository);

  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}
