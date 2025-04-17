import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class VerifyForgotScreen extends StatefulWidget {
  const VerifyForgotScreen({super.key});

  @override
  State<VerifyForgotScreen> createState() => _VerifyForgotScreenState();
}

class _VerifyForgotScreenState extends State<VerifyForgotScreen> {
  final List<FocusNode> _focusNodes = List.generate(3, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(3, (index) => TextEditingController());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    final state = context.read<AuthBloc>().state;
    final email = state.user?.email;

    final otp = _controllers.map((c) => c.text).join();
    if (email == null || otp.length != 3) {
      // Mostrar error o retornar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the 3-digit code."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(VerifyForgotEvent(
          email: email,
          otp: otp,
        ));
  }

  void _resendOtp() {
    // Enviar nuevo OTP o realizar el reenvío
    final otp = _controllers.map((e) => e.text).join();
    context.read<AuthBloc>().add(VerifyForgotEvent(
          email: "pusugu03@gmail.com",
          otp: otp,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state.isVerifyForgot) {
          Navigator.pushReplacementNamed(context, '/reset');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Verify Reset Password")),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter the 3-digit code sent to your email",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) => _buildOtpBox(index)),
              ),
              const SizedBox(height: 40),
              TextButton(onPressed: _resendOtp, child: const Text("Resend")),
              ElevatedButton(
                onPressed: _onVerify,
                child: const Text("Verify"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 22),
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 2) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
