import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class OrderEvent {}

class CreateOrder extends OrderEvent {
  final List<Product> products;

  CreateOrder({required this.products});
}

class SelectPaymentMethod extends OrderEvent {
  final String paymentMethod;
  final List<Product> products;

  SelectPaymentMethod({required this.paymentMethod, required this.products});
}

class CompletePayment extends OrderEvent {}
