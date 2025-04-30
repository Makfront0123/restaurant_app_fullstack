import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/application/presentation/screen/application_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/forgot_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/register_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/reset_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/verify_forgot_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/verify_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/screens/cart_screen.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_cat_screen.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_screen.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/screens/end_oder.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/screens/product_screen.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/screens/review_screen.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const String wrapper = '/wrapper';
  static const String application = '/application';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String cart = '/cart';
  static const String order = '/order';
  static const String profile = '/profile';
  static const String menuCat = '/menuCat';
  static const String splash = '/splash';
  static const String menu = '/menu';
  static const String product = '/product';
  static const String checkout = '/checkout';
  static const String verify = '/verify';
  static const String forgot = '/forgot';
  static const String reset = '/reset';
  static const String verifyForgot = '/verifyForgot';
  static const String review = '/review';

  static Map<String, WidgetBuilder> routes = {
    endOrder: (context) => const EndOrderScreen(),
    verifyForgot: (context) => const VerifyForgotScreen(),
    verify: (context) => const VerifyScreen(),
    reset: (context) => const ResetScreen(),
    review: (context) => const ReviewScreen(),
    splash: (context) => const SplashScreen(),
    application: (context) => const ApplicationScreen(),
    forgot: (context) => const ForgotScreen(),
    wrapper: (context) => const AuthWrapper(),
    login: (context) => const LoginScreen(),
    menuCat: (context) => const MenuCatScreen(),
    menu: (context) => const MenuScreen(),
    signup: (context) => const RegisterScreen(),
    product: (context) => const ProductScreen(),
    cart: (context) => const CartScreen(),
  };
}
