import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<String> verify(String email, String otp);
  Future<void> logout();
  Future<User> getCurrentUser(String token);
  Future<User> register(
      String name, String email, String password, String confirmPassword);
}
