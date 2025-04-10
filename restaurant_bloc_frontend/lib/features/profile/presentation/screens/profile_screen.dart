import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/widgets/avatar_user.dart';
import 'package:restaurant_bloc_frontend/features/profile/presentation/widgets/input_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const AvatarUser(),
                _buildProfileForm(),
              ],
            ),
          ),
        ));
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
        const SizedBox(
          height: 10,
        ),
        InputForm(
            controller: usernameController,
            titleForm: 'Enter your Email',
            icon: Icons.email),
        const SizedBox(
          height: 10,
        ),
        InputForm(
          controller: usernameController,
          titleForm: 'Enter your Password',
          icon: Icons.key_rounded,
        ),
        const SizedBox(
          height: 10,
        ),
        InputForm(
            controller: usernameController,
            icon: Icons.key_rounded,
            titleForm: 'Confirm Password'),
        const SizedBox(
          height: 60,
        ),
        AuthButton(
          onTap: () {},
          text: 'Explore our Menu',
        )
      ],
    ));
  }
}
