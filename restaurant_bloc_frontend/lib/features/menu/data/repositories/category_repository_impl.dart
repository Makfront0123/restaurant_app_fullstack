import 'package:restaurant_bloc_frontend/features/menu/data/datasources/remote/category_api_services.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiServices read;
  CategoryRepositoryImpl(this.read);
  @override
  Future<List<Category>> getCategories() async {
    final response = await read.getAllCategory();
    return (response['data'] as List)
        .map((e) => Category(title: e['name'], image: e['image'], id: e['_id']))
        .toList();
  }
}
