import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  final String deliveryAddress;
  final DateTime deliveryDate;
  final String token;
  final String comment;

  CreateOrderEvent({
    required this.comment,
    required this.deliveryAddress,
    required this.deliveryDate,
    required this.token,
  });
}

class SelectPaymentMethod extends OrderEvent {
  final String paymentMethod;
  final List<Product> products;

  SelectPaymentMethod({required this.paymentMethod, required this.products});
}

class CompletePayment extends OrderEvent {}

class GetOrderEvent extends OrderEvent {
  final String token;

  GetOrderEvent({required this.token});
}

class AddCommentToOrderEvent extends OrderEvent {
  final String orderId;
  final String comment;
  final String token;

  AddCommentToOrderEvent({
    required this.orderId,
    required this.comment,
    required this.token,
  });
}
