import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_event.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_state.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/screens/home_screen.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_screen.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/screens/order_screen.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc()
      : super(
          const ApplicationState(
            currentIndex: 0,
            pages: [
              HomeScreen(),
              MenuScreen(),
              OrderScreen(),
              FavoriteScreen(),
              HomeScreen()
            ],
          ),
        ) {
    on<TabChangedEvent>(_onTabChanged);
  }

  void _onTabChanged(TabChangedEvent event, Emitter<ApplicationState> emit) {
    emit(state.copyWith(currentIndex: event.newIndex));
  }
}