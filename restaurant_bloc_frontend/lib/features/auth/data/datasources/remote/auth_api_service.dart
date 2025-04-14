import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService(this._dio);

  Future<dynamic> register(String name, String email, String password,
      String confirmPassword) async {
    try {
      final response = await _dio.post('/api/v1/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword
      });
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio
          .post('/api/v1/login', data: {'email': email, 'password': password});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> logout() async {
    try {
      final response = await _dio.post('/api/v1/logout');
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> verify(String email, String otp) async {
    try {
      final response =
          await _dio.post('/api/v1/verify', data: {'email': email, 'otp': otp});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      final response =
          await _dio.post('/api/v1/forgot-password', data: {'email': email});
      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> resetPassword(
      String token, String password, String newPassword) async {
    try {
      final response = await _dio.post('/api/v1/reset-password', data: {
        'token': token,
        'password': password,
        'newPassword': newPassword
      });
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
