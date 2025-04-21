import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/services/storage_service.dart';
import 'package:restaurant_bloc_frontend/features/order/data/models/order_model.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/usecases/creater_order.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrder createOrder;

  OrderBloc(this.createOrder) : super(OrderInitial()) {
    on<SubmitOrderEvent>(_onSubmitOrder);
  }

  Future<void> _onSubmitOrder(
    SubmitOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderSubmitting());

    try {
      final storageService = StorageService();
      final token = await storageService.getToken();
      if (token == null) {
        emit(const OrderFailure('Token no encontrado'));
        return;
      }
      final request = OrderModel(
        deliveryAddress: event.deliveryAddress,
        deliveryDate: DateTime.now(),
      );

      await createOrder(request, token);
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
