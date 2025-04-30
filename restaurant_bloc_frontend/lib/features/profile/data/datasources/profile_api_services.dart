import 'package:dio/dio.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/models/user_model.dart';
import 'dart:io';

import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

class ProfileApiServices {
  final Dio _dio;
  final String baseUrl;

  ProfileApiServices(this._dio, this.baseUrl);

  Future<User> updateProfile(
    String username,
    String confirmPassword,
    String password,
    File? image,
    String token,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'name': username,
        'confirmPassword': confirmPassword,
        'password': password,
        // Si la imagen está presente, agregarla al FormData
        if (image != null) 'image': await MultipartFile.fromFile(image.path),
      });

      final response = await _dio.put(
        '$baseUrl/api/v1/edit-user',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data['data'];
      final userModel = UserModel.fromJson(data, token: token);
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}
