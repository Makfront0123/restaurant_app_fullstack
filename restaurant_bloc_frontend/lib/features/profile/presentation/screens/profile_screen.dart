// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                return const CircularProgressIndicator(); // Muestra el loading
              } else if (state is ProfileUpdated) {
                return Column(
                  children: [
                    const AvatarUser(),
                    _buildProfileForm(),
                    Text(state.message), // Muestra el mensaje de éxito
                  ],
                );
              } else if (state is ProfileError) {
                return Column(
                  children: [
                    const AvatarUser(),
                    _buildProfileForm(),
                    // Muestra el error
                  ],
                );
              }
              return Column(
                children: [
                  const AvatarUser(),
                  _buildProfileForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Form _buildProfileForm() {
    return Form(
      child: Column(
        children: [
          InputForm(
            controller: usernameController,
            titleForm: 'Enter your Username',
            icon: Icons.person,
          ),
          const SizedBox(height: 10),
          InputForm(
            controller: passwordController,
            titleForm: 'Enter your Password',
            icon: Icons.key_rounded,
          ),
          const SizedBox(height: 10),
          InputForm(
            controller: confirmPasswordController,
            titleForm: 'Confirm Password',
            icon: Icons.key_rounded,
          ),
          const SizedBox(height: 60),
          AuthButton(
            onTap: _updateProfile,
            text: 'Update Profile',
          ),
        ],
      ),
    );
  }

  void _updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final username = usernameController.text;
    final confirmPassword = confirmPasswordController.text;
    final password = passwordController.text;

    if (username.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password.isNotEmpty) {
      context.read<ProfileBloc>().add(UpdateProfileEvent(
            username: username,
            confirmPassword: confirmPassword,
            password: password,
            token: token,
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
    }
  }
}
