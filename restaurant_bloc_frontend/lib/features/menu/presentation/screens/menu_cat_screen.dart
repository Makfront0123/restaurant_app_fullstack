import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/search_input.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';

import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/product_carousel_content.dart';

class MenuCatScreen extends StatelessWidget {
  const MenuCatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String?;

    if (category == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<ProductsBloc>().add(LoadProductsByCategory(category));
    });

    return Scaffold(
      appBar: const MenuAppbar(title: 'Menu'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SearchInput(),
              const SizedBox(height: 20),
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  // Filtrar estado para mostrar los productos cargados por categoría
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoadedByCategory) {
                    return ProductCarouselContent(
                      stateFilter: (state) =>
                          state is ProductsLoadedByCategory ? state : null,
                      productExtractor: (state) =>
                          (state as ProductsLoadedByCategory).products,
                      isVertical: true,
                    );
                  } else if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox(); // O cualquier estado vacío
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
