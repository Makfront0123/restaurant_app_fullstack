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

      final user = UserModel.fromJson(userData, token: '');

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

      final data = response.data['data'];
      final token = data['token']; // <- lo sacas de aquí
      final userJson = data['user'];

      final user = UserModel.fromJson(userJson, token: token);

      return user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel> getCurrentUser(String token) async {
    try {
      final response = await _dio.get('$baseUrl/api/v1/check-auth',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final data = response.data;

      return UserModel.fromJson(data['data'], token: token);
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

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
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

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }
}
