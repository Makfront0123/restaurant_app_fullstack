import 'dart:io';

import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';
import 'package:restaurant_bloc_frontend/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;

  UpdateProfileUsecase(this.repository);

  Future<User> updateProfile(
    String username,
    String confirmPassword,
    String password,
    String token,
    File? image,
  ) {
    return repository.updateProfile(
        username, confirmPassword, password, token, image);
  }
}
