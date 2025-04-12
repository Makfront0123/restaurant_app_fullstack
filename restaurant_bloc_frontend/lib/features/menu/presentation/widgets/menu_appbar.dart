import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';

class MenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppbar({
    super.key,
    required this.title,
    this.showIcon = true,
    this.showAction = true,
  });
  final String title;
  final bool showIcon;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        leading: showIcon
            ? GestureDetector(
                onTap: () {
                  context.read<ProductsBloc>().add(LoadProductsData());
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new_rounded))
            : const SizedBox(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title),
        centerTitle: true,
        actions: [
          showAction
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: const Icon(Icons.shopping_cart))
              : const SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
