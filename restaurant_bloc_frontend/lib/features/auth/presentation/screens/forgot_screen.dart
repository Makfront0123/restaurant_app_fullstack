import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_formfield.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.green,
          ));
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacementNamed(
                // ignore: use_build_context_synchronously
                context,
                '/verifyForgot',
                arguments: emailController.text,
              );
            }
          });
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
      child: Scaffold(
        appBar: const AuthAppBar(
          title: 'Forgot Password',
        ),
        body: AuthContainer(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          padding: const EdgeInsets.all(20),
          width: width,
          height: height * 0.35,
          child: Column(
            children: [
              Text(
                style: Theme.of(context).textTheme.labelLarge,
                'Please enter your email address. You will receive a link to create a new password via email.',
              ),
              const SizedBox(height: 20),
              AuthFormfield(
                controller: emailController,
                label: 'Enter your email',
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              AuthButton(
                text: 'Send Link',
                onTap: () {
                  context
                      .read<AuthBloc>()
                      .add(ForgotEvent(email: emailController.text));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
