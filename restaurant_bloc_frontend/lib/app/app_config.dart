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
import 'package:restaurant_bloc_frontend/features/menu/data/datasources/remote/category_api_services.dart';
import 'package:restaurant_bloc_frontend/features/menu/data/repositories/category_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/repositories/category_repository.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/usecases/get_all_categories.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_blocs.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_event.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_screen.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/data/datasources/remote/product_api_services.dart';
import 'package:restaurant_bloc_frontend/features/product/data/repositories/product_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/repositories/product_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_all_products.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_product.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_products_category.dart';

class AppProvider {
  static get allproviders => [
        /// Networking
        RepositoryProvider(create: (_) => Dio()),

        /// Auth
        RepositoryProvider(
          create: (context) =>
              AuthApiService(context.read<Dio>(), 'http://10.0.2.2:3000'),
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

        /// Productos
        RepositoryProvider(
          create: (context) =>
              ProductApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(
            context.read<ProductApiServices>(),
          ),
        ),
        RepositoryProvider(
          create: (context) =>
              GetAllProducts(context.read<ProductRepository>()),
        ),
        RepositoryProvider(
          create: (context) => GetProduct(context.read<ProductRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetProductsByCategory(context.read<ProductRepository>()),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(
            getAllProducts: context.read<GetAllProducts>(),
            getProduct: context.read<GetProduct>(),
            getProductsByCategory: context.read<GetProductsByCategory>(),
          )..add(LoadProductsData()),
        ),

        //Category
        RepositoryProvider(
          create: (context) =>
              CategoryApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepositoryImpl(
            context.read<CategoryApiServices>(),
          ),
        ),

        RepositoryProvider(
          create: (context) =>
              GetAllCategories(context.read<CategoryRepository>()),
        ),
        BlocProvider(
          create: (context) => MenuBloc(
            getAllCategories: context.read<GetAllCategories>(),
          )..add(LoadCategories()),
        ),

        /// General
        BlocProvider(create: (_) => ApplicationBloc()),
        BlocProvider(create: (_) => ThemeBloc()),

        /// Home y relacionados
        RepositoryProvider(create: (_) => HomeRepository()),
        BlocProvider(
          create: (context) => HomeBloc(context.read<HomeRepository>()),
        ),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => OrderBloc()),
        BlocProvider(create: (_) => CartBloc()),

        /// Búsqueda
        BlocProvider(
          create: (context) => SearchBloc(context.read<HomeRepository>()),
          child: const MenuScreen(), // Esto no va acá realmente (ver abajo)
        ),
      ];
}
