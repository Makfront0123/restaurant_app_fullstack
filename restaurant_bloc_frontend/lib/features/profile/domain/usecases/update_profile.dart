import 'package:restaurant_bloc_frontend/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository _profileRepository;

  UpdateProfileUsecase(this._profileRepository);

  Future<void> updateProfile(String username, String confirmPassword,
      String password, String token) async {
    await _profileRepository.updateProfile(
        username, confirmPassword, password, token);
  }
}
