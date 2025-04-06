import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/register_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_cat_screen.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/screens/menu_screen.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/screens/product_screen.dart';

class AppRoutes {
  static const String wrapper = '/';
  static const String application = '/application';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String cart = '/cart';
  static const String order = '/order';
  static const String profile = '/profile';
  static const String menuCat = '/menuCat';
  static const String menu = '/menu';
  static const String product = '/product';

  static Map<String, WidgetBuilder> routes = {
    wrapper: (context) => const AuthWrapper(),
    login: (context) => const LoginScreen(),
    menuCat: (context) => const MenuCatScreen(),
    menu: (context) => const MenuScreen(),
    signup: (context) => const RegisterScreen(),
    product: (context) => const ProductScreen()
  };
}
