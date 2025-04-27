import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_bloc_frontend/app/app_config.dart';
import 'package:restaurant_bloc_frontend/app/router.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY'] ?? '';
  await Stripe.instance.applySettings();
  runApp(
    MultiProvider(
      providers: AppProvider.allproviders,
      child: const MyApp(),
    ),
  );
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
