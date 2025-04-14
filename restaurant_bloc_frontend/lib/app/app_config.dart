import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/logout_auth.dart';
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
        RepositoryProvider(create: (_) => Dio()),
        RepositoryProvider(
          create: (context) => AuthApiService(context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) =>
              AuthRepositoryImpl(context.read<AuthApiService>()),
        ),
        RepositoryProvider(
          create: (context) => LoginUser(context.read<AuthRepositoryImpl>()),
        ),
        RepositoryProvider(
          create: (context) => LogoutUser(context.read<AuthRepositoryImpl>()),
        ),

        BlocProvider(
          create: (context) => AuthBloc(
            loginUser: context.read<LoginUser>(),
            logoutUser: context.read<LogoutUser>(),
          ),
        ),

        // Otros providers...
        BlocProvider(create: (_) => ApplicationBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
        RepositoryProvider(create: (_) => HomeRepository()),
        RepositoryProvider(create: (_) => ProductsRepository()),

        BlocProvider(
          create: (context) => HomeBloc(context.read<HomeRepository>()),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(context.read<ProductsRepository>())
            ..add(LoadProductsData()),
        ),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => OrderBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(
          create: (context) => SearchBloc(context.read<HomeRepository>()),
          child: const MenuScreen(),
        ),
      ];
}
