abstract class ProfileRepository {
  Future<void> updateProfile(
      String username, String confirmPassword, String password, String token);
}
