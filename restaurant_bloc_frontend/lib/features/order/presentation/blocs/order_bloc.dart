import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/usecases/create_order.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUsecase _createOrderUsecase;

  OrderBloc({required CreateOrderUsecase createOrderUsecase})
      : _createOrderUsecase = createOrderUsecase,
        super(OrderInitial()) {
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<CreateOrderEvent>(_onCreateOrder);
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<OrderState> emit) {
    emit(PaymentMethodSelected(selectedPaymentMethod: event.paymentMethod));
  }

  Future<void> _onCreateOrder(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderCreating());

    try {
      final order = await _createOrderUsecase(
        token: event.token,
        deliveryAddress: event.deliveryAddress,
        deliveryDate: event.deliveryDate,
      );
      emit(OrderCreated(order: order));
    } catch (e) {
      emit(OrderFailed(error: e.toString()));
    }
  }
}









/*
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUsecase _createOrderUsecase;

  OrderBloc({required CreateOrderUsecase createOrderUsecase})
      : _createOrderUsecase = createOrderUsecase,
        super(OrderInitial()) {
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
  }
  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<OrderState> emit) async {
    emit(PaymentMethodSelected(selectedPaymentMethod: event.paymentMethod));
  }
}
 */
