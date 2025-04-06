import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/utils/validator_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/screens/register_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_body.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const AuthAppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AuthBody(
        child: buildLoginLocal(formKey),
      ),
    );
  }

  Widget buildLoginLocal(formKey) {
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
          const SizedBox(
            height: 50,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildEmailField(),
                  const SizedBox(
                    height: 15,
                  ),
                  buildPasswordField(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginEvent());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 60),
                  AuthButton(

                     onTap: () {
                      context.read<AuthBloc>().add(LoginEvent());
                      print('clicked');
                    },
                    text: 'Sign In',
                  ),
                ],
              )),
          const SizedBox(
            height: 30,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.labelMedium),
            TextSpan(
              text: 'Sign Up',
              style: Theme.of(context).textTheme.labelSmall,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
            ),
          ])),
        ],
      ),
    );
  }

  buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
          labelText: 'Enter your email',
          hintText: 'Enter your email',
          labelStyle: Theme.of(context).textTheme.labelMedium,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.email,
                  color: Colors.white,
                )),
          )),
      validator: (value) => Validators.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
    );
  }

  buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          labelText: 'Enter your password',
          hintText: 'Enter your password',
          labelStyle: Theme.of(context).textTheme.labelMedium,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.key_rounded,
                  color: Colors.white,
                )),
          )),
      validator: (value) => Validators.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
