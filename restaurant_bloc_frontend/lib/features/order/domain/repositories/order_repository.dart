import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class OrderRepository {
  Future<void> createOrder(List<Product> products);
}
