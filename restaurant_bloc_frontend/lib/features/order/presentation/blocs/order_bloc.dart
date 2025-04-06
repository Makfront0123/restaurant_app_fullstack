import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState());

  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is OrderEventOrder) {
      yield OrderState(isOrder: true);
    } else if (event is OrderEventUnorder) {
      yield OrderState(isOrder: false);
    }
  }
}
