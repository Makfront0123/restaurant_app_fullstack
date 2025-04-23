import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderCreating extends OrderState {}

class OrderCreated extends OrderState {
  final Order order;

  OrderCreated({required this.order});
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

// Estado para manejar el método de pago seleccionado
class PaymentMethodSelected extends OrderState {
  final String selectedPaymentMethod;

  PaymentMethodSelected({required this.selectedPaymentMethod});
}
