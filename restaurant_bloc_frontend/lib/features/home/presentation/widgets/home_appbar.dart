import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
    this.showUser = true,
  });
  final bool showUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AppBar(
        leadingWidth: showUser ? 195 : 80,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(Images.user),
              radius: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            showUser
                ? Text('Armando Sanchez',
                    style: Theme.of(context).textTheme.titleMedium)
                : Container()
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
