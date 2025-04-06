import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/utils/validator_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_body.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const AuthAppBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AuthBody(
        child: buildRegisterLocal(formKey),
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
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildUsernameField(),
                  const SizedBox(
                    height: 14,
                  ),
                  buildEmailField(),
                  const SizedBox(
                    height: 14,
                  ),
                  buildPasswordField(),
                  const SizedBox(
                    height: 14,
                  ),
                  buildConfirmPasswordField(),
                  const SizedBox(
                    height: 40,
                  ),
                  AuthButton(
                    onTap: () {},
                    text: 'Sign Up',
                  ),
                ],
              )),
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
                  // En el botón/ruta de SignUp:
                  Navigator.pushReplacementNamed(context, '/login');
                },
            ),
          ])),
        ],
      ),
    );
  }

  buildUsernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
          labelText: 'Enter your username',
          hintText: 'Enter your username',
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
                  Icons.person,
                  color: Colors.white,
                )),
          )),
      validator: (value) => Validators.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
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

  buildConfirmPasswordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          labelText: 'Confirm your password',
          hintText: 'Confirm your password',
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
