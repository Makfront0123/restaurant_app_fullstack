import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/services/storage_service.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:restaurant_bloc_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/forgot_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/login_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/logout_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/register_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/resend_otp_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/resend_otp_forgot.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/reset_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/verify_forgot.dart';
import 'package:restaurant_bloc_frontend/features/auth/domain/usecases/verify_otp_user.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/cart/data/datasources/remote/cart_api_services.dart';
import 'package:restaurant_bloc_frontend/features/cart/data/repository/cart_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/usecases/add_product.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/usecases/get_cart.dart';
import 'package:restaurant_bloc_frontend/features/cart/domain/usecases/remove_product.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';

import 'package:restaurant_bloc_frontend/features/favorite/data/datasources/remote/favorite_api_services.dart';
import 'package:restaurant_bloc_frontend/features/favorite/data/repository/favorite_respository_impl.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/usecases/add_favorite.dart';
import 'package:restaurant_bloc_frontend/features/favorite/domain/usecases/get_favorite.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/data/datasources/home_api_services.dart';
import 'package:restaurant_bloc_frontend/features/home/data/repositories/home_repository_impl.dart';

import 'package:restaurant_bloc_frontend/features/home/domain/usecases/get_categories.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/menu/data/datasources/remote/category_api_services.dart';
import 'package:restaurant_bloc_frontend/features/menu/data/repositories/category_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/repositories/category_repository.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/usecases/get_all_categories.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_blocs.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_event.dart';

import 'package:restaurant_bloc_frontend/features/order/data/datasources/remote/order_api_services.dart';
import 'package:restaurant_bloc_frontend/features/order/data/repository/order_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/usecases/create_order.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/usecases/get_order_user.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/data/datasources/remote/product_api_services.dart';
import 'package:restaurant_bloc_frontend/features/product/data/repositories/product_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/repositories/product_repository.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/profile/data/datasources/profile_api_services.dart';
import 'package:restaurant_bloc_frontend/features/profile/data/repository/profile_repository_impl.dart';
import 'package:restaurant_bloc_frontend/features/profile/domain/usecases/update_profile.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/blocs/profile_bloc.dart';

import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_all_products.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_product.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/usecases/get_products_category.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/blocs/splash_bloc.dart';

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
            create: (context) => ResendOtp(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                ResendOtpForgot(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) => ResetAuth(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                VerifyAccount(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(create: (context) => StorageService()),
        RepositoryProvider(
            create: (context) =>
                VerifyForgot(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                ForgotAuth(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                RegisterUser(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) => LoginUser(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                LogoutUser(context.read<AuthRepositoryImpl>())),
        BlocProvider(
          create: (context) => AuthBloc(
            storageService: context.read<StorageService>(),
            resendOtpForgot: context.read<ResendOtpForgot>(),
            resendOtp: context.read<ResendOtp>(),
            verifyForgot: context.read<VerifyForgot>(),
            resetPassword: context.read<ResetAuth>(),
            forgotPassword: context.read<ForgotAuth>(),
            verifyOtp: context.read<VerifyAccount>(),
            registerUser: context.read<RegisterUser>(),
            loginUser: context.read<LoginUser>(),
            logoutUser: context.read<LogoutUser>(),
          )..add(AppStarted()),
        ),

        // Splash
        BlocProvider(create: (_) => SplashBloc()),

        /// Productos
        RepositoryProvider(
          create: (context) =>
              ProductApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) =>
              ProductRepositoryImpl(context.read<ProductApiServices>()),
        ),
        RepositoryProvider(
            create: (context) =>
                GetAllProducts(context.read<ProductRepository>())),
        RepositoryProvider(
            create: (context) => GetProduct(context.read<ProductRepository>())),
        RepositoryProvider(
            create: (context) =>
                GetProductsByCategory(context.read<ProductRepository>())),
        BlocProvider(
          create: (context) => ProductsBloc(
            getAllProducts: context.read<GetAllProducts>(),
            getProduct: context.read<GetProduct>(),
            getProductsByCategory: context.read<GetProductsByCategory>(),
          )..add(LoadProductsData()),
        ),

        // Categorías
        RepositoryProvider(
          create: (context) =>
              CategoryApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) =>
              CategoryRepositoryImpl(context.read<CategoryApiServices>()),
        ),
        RepositoryProvider(
            create: (context) =>
                GetAllCategories(context.read<CategoryRepository>())),
        BlocProvider(
          create: (context) => MenuBloc(
            getAllCategories: context.read<GetAllCategories>(),
          )..add(LoadCategories()),
        ),

        // General
        BlocProvider(create: (_) => ApplicationBloc()),
        BlocProvider(create: (_) => ThemeBloc()),

        // Home
        RepositoryProvider(
          create: (context) =>
              HomeApiServices('http://10.0.2.2:3000', context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) =>
              HomeRepositoryImpl(context.read<HomeApiServices>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetCategoriesUseCase(context.read<HomeRepositoryImpl>()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            getCategoriesUseCase: context.read<GetCategoriesUseCase>(),
            homeRepository: context.read<HomeRepositoryImpl>(),
          ),
        ),

        // Favorite
        RepositoryProvider(
          create: (context) =>
              FavoriteApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider(
          create: (context) =>
              FavoriteRepositoryImpl(context.read<FavoriteApiServices>()),
        ),
        RepositoryProvider(
            create: (context) =>
                AddFavoriteUsecase(context.read<FavoriteRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                GetFavoriteUsecase(context.read<FavoriteRepositoryImpl>())),
        BlocProvider(
          create: (context) => FavoriteBloc(
            getFavorite: context.read<GetFavoriteUsecase>(),
            addFavorite: context.read<AddFavoriteUsecase>(),
          ),
        ),

        // Orders
        RepositoryProvider(
          create: (context) =>
              OrderApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider(
          create: (context) =>
              OrderRepositoryImpl(context.read<OrderApiServices>()),
        ),
        RepositoryProvider(
            create: (context) =>
                CreateOrderUsecase(context.read<OrderRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                GetOrderUsercase(context.read<OrderRepositoryImpl>())),
        BlocProvider(
          create: (context) => OrderBloc(
            createOrderUsecase: context.read<CreateOrderUsecase>(),
            getOrderUsercase: context.read<GetOrderUsercase>(),
          ),
        ),

        // Cart
        RepositoryProvider(
          create: (context) =>
              CartApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider(
          create: (context) =>
              CartRepositoryImpl(context.read<CartApiServices>()),
        ),
        RepositoryProvider(
            create: (context) =>
                AddCartUsecase(context.read<CartRepositoryImpl>())),
        RepositoryProvider(
            create: (context) => RemoveProductFromCartUsecase(
                context.read<CartRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                GetCartUsecase(context.read<CartRepositoryImpl>())),
        BlocProvider(
          create: (context) => CartBloc(
            getCart: context.read<GetCartUsecase>(),
            removeProductFromCart: context.read<RemoveProductFromCartUsecase>(),
            addProductToCart: context.read<AddCartUsecase>(),
          ),
        ),

        // Profile
        RepositoryProvider(
          create: (context) =>
              ProfileApiServices(context.read<Dio>(), 'http://10.0.2.2:3000'),
        ),
        RepositoryProvider(
          create: (context) =>
              ProfileRepositoryImpl(context.read<ProfileApiServices>()),
        ),
        RepositoryProvider(
            create: (context) =>
                UpdateProfileUsecase(context.read<ProfileRepositoryImpl>())),
        RepositoryProvider(
          create: (context) => ProfileBloc(
            updateProfile: context.read<UpdateProfileUsecase>(),
          ),
        ),

        // Search
        BlocProvider(
          create: (context) => SearchBloc(context.read<HomeRepositoryImpl>()),
        ),
      ];
}
