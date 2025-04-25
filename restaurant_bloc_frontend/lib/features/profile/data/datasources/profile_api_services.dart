import 'package:dio/dio.dart';

class ProfileApiServices {
  final Dio _dio;
  final String baseUrl;

  ProfileApiServices(this._dio, this.baseUrl);

  Future<void> updateProfile(String username, String confirmPassword,
      String password, String token) async {
    try {
      final response = await _dio.put('$baseUrl/api/v1/edit-user',
          data: {
            'name': username,
            'confirmPassword': confirmPassword,
            'password': password,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final message = response.data['message'];
      return message;
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}
