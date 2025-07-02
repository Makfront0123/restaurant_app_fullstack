import 'package:restaurant_bloc_frontend/features/order/domain/entities/order_item.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderCreating extends OrderState {}

class OrderLoading extends OrderState {}

class OrderCreated extends OrderState {
  final Order order;

  OrderCreated({required this.order});
}

class OrderByUser extends OrderState {
  final List<Order> orders;

  OrderByUser({required this.orders});
}

class OrderFailed extends OrderState {
  final String error;

  OrderFailed({required this.error});
}

class PaymentProcessing extends OrderState {}

class PaymentCompleted extends OrderState {
  final String paymentConfirmation;

  PaymentCompleted({required this.paymentConfirmation});
}

class PaymentFailed extends OrderState {
  final String errorMessage;

  PaymentFailed({required this.errorMessage});
}

class PaymentMethodSelected extends OrderState {
  final String selectedPaymentMethod;

  PaymentMethodSelected({required this.selectedPaymentMethod});
}
