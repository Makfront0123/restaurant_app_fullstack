import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/app/router.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return _buildDrawer(context, state);
      },
    );
  }

  Widget _buildDrawer(BuildContext context, AuthState state) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Parte superior del Drawer con la imagen y los datos del usuario
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Theme.of(context).splashColor,
                width: 1,
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(Images.user),
                  radius: 40,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.user?.name ?? 'No Name',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      state.user?.email ?? 'No Email',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Sección con las opciones del Drawer
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    context.read<AuthBloc>().add(const LogoutEvent());

                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                    Navigator.pop(context); // Cierra el drawer
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
