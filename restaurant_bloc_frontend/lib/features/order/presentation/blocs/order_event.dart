import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class SubmitOrderEvent extends OrderEvent {
  final String deliveryAddress;

  const SubmitOrderEvent(this.deliveryAddress);

  @override
  List<Object?> get props => [deliveryAddress];
}
