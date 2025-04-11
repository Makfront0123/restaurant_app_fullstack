import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/search_input.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/product_carousel_content.dart';

class MenuCatScreen extends StatefulWidget {
  const MenuCatScreen({super.key});

  @override
  State<MenuCatScreen> createState() => _MenuCatScreenState();
}

class _MenuCatScreenState extends State<MenuCatScreen> {
  late String? selectedCategory;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as String?;

    if (args == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return;
    }

    selectedCategory = args;
    context
        .read<ProductsBloc>()
        .add(LoadProductsByCategory(selectedCategory ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MenuAppbar(
          title: 'Menu',
        ),
        body: Padding(
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
        ));
  }
}
