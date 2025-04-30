import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_bloc.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_event.dart';
import 'package:restaurant_bloc_frontend/core/theme/blocs/theme_state.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_event.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: _buildDrawer(context, state),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context, AuthState state) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: state is Authenticated &&
                            state.user.imageUser.isNotEmpty
                        ? NetworkImage(state.user.imageUser)
                        : const AssetImage(
                            Images.user,
                          ),
                    radius: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is Authenticated)
                          Text(
                            state.user.name,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          const Text('No Name'),
                        if (state is Authenticated)
                          Text(
                            state.user.email,
                            style: Theme.of(context).textTheme.labelSmall,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          const Text('No Email'),
                      ],
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthBloc>().add(const LogoutEvent());
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    final isDark =
                        themeState.themeData.brightness == Brightness.dark;

                    return CupertinoSwitch(
                      value: isDark,
                      onChanged: (_) {
                        context.read<ThemeBloc>().add(ToogleTheme());
                      },
                    );
                  },
                ),
                const SizedBox(width: 16),
                const Text('Dark Mode'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
