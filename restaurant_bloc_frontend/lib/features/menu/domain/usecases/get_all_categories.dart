import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/repositories/category_repository.dart';

class GetAllCategories {
  final CategoryRepository repository;

  GetAllCategories(this.repository);

  Future<List<Category>> call() async {
    return await repository.getCategories();
  }
}
