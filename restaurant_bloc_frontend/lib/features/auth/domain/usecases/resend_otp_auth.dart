import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class ResendOtp {
  final AuthRepository repository;

  ResendOtp(this.repository);

  Future<Map<String, dynamic>> call(String email) {
    return repository.resendOtp(email);
  }
}
