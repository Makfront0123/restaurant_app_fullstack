import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/repositories/home_repository.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_screen.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/data/repositories/product_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';

class AppProvider {
  static get allproviders => [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => ApplicationBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
        RepositoryProvider(create: (_) => HomeRepository()),
        RepositoryProvider(create: (_) => ProductsRepository()),
        BlocProvider(
          create: (context) => HomeBloc(
            context.read<HomeRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(ProductsRepository())
            ..add(
              LoadProductsData(),
            ),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(HomeRepository()),
          child: const MenuScreen(),
        ),
      ];
}
