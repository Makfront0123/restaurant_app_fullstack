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
  }
  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<OrderState> emit) async {
    emit(PaymentMethodSelected(selectedPaymentMethod: event.paymentMethod));
  }
}
