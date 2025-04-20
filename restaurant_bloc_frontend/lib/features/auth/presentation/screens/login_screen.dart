import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/utils/validator_auth.dart';
import 'package:restaurant_bloc_frontend/features/application/presentation/widgets/load_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_body.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _onLogin() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(
            email: emailController.text,
            password: passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          print('AuthState: $state');
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/application');
          }
          if (state is AuthVerificationSuccess) {
            Navigator.pushReplacementNamed(context, '/verify');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            context.read<AuthBloc>().add(ResetAuthState());
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return LoadScreen(
            isLoading: isLoading,
            child: Scaffold(
              appBar: const AuthAppBar(),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: AuthBody(
                child: buildLoginLocal(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoginLocal() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Sign in to continue',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 50),
          _buildLoginForm(formKey),
          const SizedBox(height: 30),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: 'Sign Up',
                style: Theme.of(context).textTheme.labelSmall,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/signup');
                  },
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(formKey) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AuthFormfield(
            controller: emailController,
            label: "Enter your email",
            icon: Icons.email,
            validator: (value) => Validators.validateEmail(value),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          AuthFormfield(
            controller: passwordController,
            label: "Enter your password",
            icon: Icons.key_rounded,
            validator: (value) => Validators.validatePassword(value),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/forgot');
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 60),
          AuthButton(
            onTap: _onLogin,
            text: 'Sign In',
          ),
        ],
      ),
    );
  }
}
