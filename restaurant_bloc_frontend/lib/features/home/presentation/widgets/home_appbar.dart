import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/blocs/auth_state.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
    this.showUser = true,
    this.title,
  });
  final bool showUser;

  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return _buildAppBar(context, state);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildAppBar(BuildContext context, AuthState state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AppBar(
        centerTitle: true,
        title: Text(title ?? ''),
        leadingWidth: showUser ? 195 : 80,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                backgroundImage:
                    state is Authenticated && state.user.imageUser.isNotEmpty
                        ? NetworkImage(state.user.imageUser)
                        : const AssetImage(Images.user),
                radius: 20,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            if (state is Authenticated)
              showUser
                  ? Text(
                      state.user.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  : const Text('')
            else
              const Text('No Name'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
