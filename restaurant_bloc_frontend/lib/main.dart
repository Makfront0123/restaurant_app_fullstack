import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/app/app_config.dart';
import 'package:restaurant_bloc_frontend/app/router.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_state.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    ...AppProvider.allproviders,
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant App Bloc',
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
          theme: state.themeData,
        );
      },
    );
  }
}




/*
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleDeepLinks();
  }

  void _handleDeepLinks() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null &&
          uri.scheme == 'restaurantapp' &&
          uri.host == 'reset-password') {
        final token = uri.queryParameters['token'];
        final email = uri.queryParameters['email'];

        // Redirigir al usuario a la pantalla de reset
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(email: email!, token: token!),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Bienvenido')),
      ),
    );
  }
}

 */