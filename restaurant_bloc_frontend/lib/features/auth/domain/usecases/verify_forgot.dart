import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class VerifyForgot {
  final AuthRepository repository;

  VerifyForgot(this.repository);

  Future<Map<String, dynamic>> call(String otp, String email) async {
    return repository.verifyForgot(email, otp);
  }
}
