import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.arrow_back_ios_new_rounded),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
