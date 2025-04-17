import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_formfield.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isReset) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, '/login');
            }
          });
        } else if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: const AuthAppBar(title: 'Reset Password'),
        body: AuthContainer(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          padding: const EdgeInsets.all(20),
          width: width,
          height: height * 0.4,
          child: Column(
            children: [
              Text(
                style: Theme.of(context).textTheme.labelLarge,
                'Enter your new password below.',
              ),
              const SizedBox(height: 20),
              AuthFormfield(
                controller: passwordController,
                label: 'Enter your new password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              AuthFormfield(
                controller: confirmPasswordController,
                label: 'Confirm your new password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 30),
              AuthButton(text: 'Reset Password', onTap: _onReset),
            ],
          ),
        ),
      ),
    );
  }

  void _onReset() {
    final state = context.read<AuthBloc>().state;
    final email = state.user?.email;
    final token = state.token;
    context.read<AuthBloc>().add(
          ResetPasswordEvent(
            token: token ?? '',
            email: email ?? '',
            password: passwordController.text,
            newPassword: confirmPasswordController.text,
          ),
        );
  }
}
