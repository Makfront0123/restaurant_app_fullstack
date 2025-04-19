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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _onRegister() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterEvent(
            name: usernameController.text,
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistrationSuccess) {
            final email = state.user.email;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('OTP sent to your email.'),
              backgroundColor: Colors.green,
            ));
            Navigator.pushNamed(context, '/verify', arguments: email);
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
                child: buildRegisterLocal(formKey),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRegisterLocal(formKey) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          _buildRegisterForm(formKey),
          const SizedBox(
            height: 30,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Already havean account? ',
                style: Theme.of(context).textTheme.labelMedium),
            TextSpan(
              text: 'Sign In',
              style: Theme.of(context).textTheme.labelSmall,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
            ),
          ])),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(formKey) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AuthFormfield(
            controller: usernameController,
            label: "Enter your username",
            icon: Icons.person,
            validator: (value) => Validators.validateUsername(value),
          ),
          const SizedBox(height: 14),
          AuthFormfield(
            controller: emailController,
            label: "Enter your email",
            icon: Icons.email,
            validator: (value) => Validators.validateEmail(value),
          ),
          const SizedBox(height: 14),
          AuthFormfield(
            controller: passwordController,
            label: "Enter your password",
            icon: Icons.key_rounded,
            validator: (value) => Validators.validatePassword(value),
            obscureText: true,
          ),
          const SizedBox(height: 14),
          AuthFormfield(
            controller: confirmPasswordController,
            label: "Confirm your password",
            icon: Icons.key_rounded,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          AuthButton(
            onTap: _onRegister,
            text: 'Sign Up',
          ),
        ],
      ),
    );
  }
}
