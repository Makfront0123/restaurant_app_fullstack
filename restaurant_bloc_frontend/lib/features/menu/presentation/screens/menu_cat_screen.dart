import 'package:flutter/material.dart';

import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/search_input.dart';

import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/product_carousel_content.dart';

class MenuCatScreen extends StatefulWidget {
  const MenuCatScreen({super.key});

  @override
  State<MenuCatScreen> createState() => _MenuCatScreenState();
}

class _MenuCatScreenState extends State<MenuCatScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String?;
    print(category);
    if (category == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        appBar: const MenuAppbar(
          title: 'Menu',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const SearchInput(),
                const SizedBox(height: 70),
                ProductCarouselContent(
                  stateFilter: (state) =>
                      state is ProductsLoadedByCategory ? state : null,
                  productExtractor: (state) =>
                      (state as ProductsLoadedByCategory).products,
                  isVertical: true,
                )
              ],
            ),
          ),
        ));
  }
}
