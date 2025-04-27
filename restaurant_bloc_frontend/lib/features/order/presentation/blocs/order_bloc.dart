import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/usecases/create_order.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/usecases/get_order_user.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUsecase _createOrderUsecase;
  final GetOrderUsercase _getOrderUsercase;

  OrderBloc(
      {required CreateOrderUsecase createOrderUsecase,
      required GetOrderUsercase getOrderUsercase})
      : _createOrderUsecase = createOrderUsecase,
        _getOrderUsercase = getOrderUsercase,
        super(OrderInitial()) {
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<CreateOrderEvent>(_onCreateOrder);
    on<GetOrderEvent>(_onGetOrder);
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

  Future<void> _onGetOrder(
      GetOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      final orders = await _getOrderUsercase(token: event.token);
      emit(OrderByUser(orders: orders));
    } catch (e) {
      emit(OrderFailed(error: e.toString()));
    }
  }
}
