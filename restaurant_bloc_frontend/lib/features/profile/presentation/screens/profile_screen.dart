// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/utils/validator_auth.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/blocs/profile_event.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/blocs/profile_state.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/widgets/avatar_user.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/widgets/input_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppbar(
        title: 'Edit Profile',
        showIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const CircularProgressIndicator();
              } else if (state is ProfileUpdated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                });
                usernameController.clear();
                passwordController.clear();
                confirmPasswordController.clear();

                return _buildProfileContent(state);
              } else if (state is ProfileError) {
                return const SizedBox.shrink();
              }
              return _buildProfileContent(state);
            },
          ),
        ),
      ),
    );
  }

  Column _buildProfileContent(state) {
    return Column(
      children: [
        const AvatarUser(),
        const SizedBox(height: 20),
        _buildProfileForm(state),
      ],
    );
  }

  Form _buildProfileForm(state) {
    return Form(
      child: Column(
        children: [
          InputForm(
            controller: usernameController,
            titleForm: 'Enter your Username',
            icon: Icons.person,
            validator: (value) => Validators.validateUsername(value),
          ),
          const SizedBox(height: 10),
          InputForm(
              controller: passwordController,
              titleForm: 'Enter your Password',
              icon: Icons.key_rounded,
              obscureText: true,
              validator: (value) => Validators.validatePassword(value)),
          const SizedBox(height: 10),
          InputForm(
              controller: confirmPasswordController,
              titleForm: 'Confirm Password',
              icon: Icons.key_rounded,
              obscureText: true,
              validator: (value) => Validators.validatePassword(value)),
          const SizedBox(height: 60),
          AuthButton(
            onTap: _updateProfile,
            text: 'Update Profile',
          )
        ],
      ),
    );
  }

  void _updateProfile() async {
    // ✅ sin parámetros
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final username = usernameController.text;
    final confirmPassword = confirmPasswordController.text;
    final password = passwordController.text;

    context.read<ProfileBloc>().add(UpdateProfileEvent(
          username: username,
          confirmPassword: confirmPassword,
          password: password,
          token: token,
        ));
  }
}
