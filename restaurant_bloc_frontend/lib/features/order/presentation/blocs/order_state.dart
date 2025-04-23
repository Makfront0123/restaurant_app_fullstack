import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderCreatedState extends OrderState {
  final List<Product> products;

  OrderCreatedState({required this.products});
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
