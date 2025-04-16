import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUser {
  final AuthRepository repository;

  VerifyOtpUser(this.repository);

  Future<void> call(String otp, String email) {
    return repository.verify(email, otp);
  }
}
