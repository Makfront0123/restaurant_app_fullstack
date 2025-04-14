import 'package:restaurant_bloc_frontend/features/auth/domain/entities/user.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
