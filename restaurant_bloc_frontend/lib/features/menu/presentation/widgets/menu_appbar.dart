import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_event.dart';

class MenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        leading: GestureDetector(
            onTap: () {
              context
                  .read<HomeBloc>()
                  .add(LoadHomeData()); // Recargar productos
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Menu'),
        centerTitle: true,
        actions: const [Icon(Icons.shopping_cart)],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
