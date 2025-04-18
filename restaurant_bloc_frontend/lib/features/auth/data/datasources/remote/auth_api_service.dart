import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/models/user_model.dart';

class AuthApiService {
  final Dio _dio;
  final String baseUrl;

  AuthApiService(this._dio, this.baseUrl);

  Future<UserModel> register(String name, String email, String password,
      String confirmPassword) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword
      });

      final userData = response.data['data']['user'];

      final user = UserModel.fromJson(userData);

      return user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/login', data: {
        'email': email,
        'password': password,
      });

      final userData = response.data['data'];
      final user = UserModel.fromJson(userData);
      return user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> logout() async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/logout');
      final message = response.data['message'];
      return message;
    } catch (e) {
      return e;
    }
  }

  Future<String> verify(String email, String otp) async {
    try {
      final response = await _dio
          .post('$baseUrl/api/v1/verify', data: {'email': email, 'otp': otp});

      final message = response.data['message'];
      return message;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        '$baseUrl/api/v1/forgot-password',
        data: {'email': email},
      );
      print('ForgotPassword response: ${response.data}');

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<Map<String, dynamic>> verifyForgot(String email, String otp) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/verify-forgot',
          data: {'email': email, 'otp': otp});

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String email, String token, String password, String newPassword) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/reset-password', data: {
        'email': email,
        'token': token,
        'password': password,
        'newPassword': newPassword
      });
      print('ResetPassword response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<dynamic> getCurrentUser(String token) async {
    try {
      final response = await _dio.get('/api/v1/user/current', data: {
        'token': token,
      });
      return response.data;
    } catch (e) {
      return e;
    }
  }

  String _extractErrorMessage(DioException e) {
    try {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String) return message;
      }

      if (data is String) return data;

      return e.message ?? 'Login failed';
    } catch (_) {
      return 'Login failed';
    }
  }

  Future<Map<String, dynamic>> resendOtp(String email) async {
    try {
      final response = await _dio.post('$baseUrl/api/v1/resend-otp', data: {
        'email': email,
      });

      print('ResendOtp response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<Map<String, dynamic>> resendForgotPasswordOtp(String email) async {
    try {
      final response =
          await _dio.post('$baseUrl/api/v1/resend-forgot-otp', data: {
        'email': email,
      });
      print('ResendForgotPasswordOtp response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }
}
