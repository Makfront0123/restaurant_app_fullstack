import 'package:restaurant_bloc_frontend/features/application/services/storage_service.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';

class AppStarted {
  final StorageService storageService;
  final LoginUser loginUser;

  AppStarted({
    required this.storageService,
    required this.loginUser,
  });

  Future<User?> call() async {
    final token = await storageService.getToken();
    if (token != null) {
      try {
        final user = await loginUser.autoLoginWithToken(token);
        return user;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
