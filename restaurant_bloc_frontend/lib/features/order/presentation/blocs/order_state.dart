import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderSubmitting extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderSuccess extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderFailure extends OrderState {
  final String message;

  const OrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}
