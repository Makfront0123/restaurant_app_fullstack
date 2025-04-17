import 'package:restaurant_bloc_frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService authApiService;

  AuthRepositoryImpl(this.authApiService);

  @override
  Future<User> login(String email, String password) async {
    final userModel = await authApiService.login(email, password);
    return userModel;
  }

  @override
  Future<User> register(String name, String email, String password,
      String confirmPassword) async {
    final userModel =
        await authApiService.register(name, email, password, confirmPassword);
    return userModel;
  }

  @override
  Future<Map<String, dynamic>> resendOtp(String email) async {
    return await authApiService.resendOtp(email);
  }

  @override
  Future<void> logout() async {
    return await authApiService.logout();
  }

  @override
  Future<String> verify(String email, String otp) async {
    final message = await authApiService.verify(email, otp);
    return message;
  }

  @override
  Future<Map<String, dynamic>> verifyForgot(String email, String otp) async {
    return await authApiService.verifyForgot(email, otp);
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    return await authApiService.forgotPassword(email);
  }

  @override
  Future<Map<String, dynamic>> resetPassword(
      String email, String token, String password, String newPassword) async {
    return await authApiService.resetPassword(
        email, token, password, newPassword);
  }

  @override
  Future<User> getCurrentUser(String token) async {
    return await authApiService.getCurrentUser(token);
  }
}
