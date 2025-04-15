import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}
