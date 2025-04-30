import 'dart:io';

import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';
import 'package:restaurant_bloc_frontend/features/profile/data/datasources/profile_api_services.dart';
import 'package:restaurant_bloc_frontend/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiServices cartApiServices;

  ProfileRepositoryImpl(this.cartApiServices);

  @override
  Future<User> updateProfile(String username, String confirmPassword,
      String password, String token, File? image) async {
    return await cartApiServices.updateProfile(
        username, confirmPassword, password, image, token);
  }
}
