import 'dart:io';

import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<User> updateProfile(String username, String confirmPassword,
      String password, String token, File? image);
}
