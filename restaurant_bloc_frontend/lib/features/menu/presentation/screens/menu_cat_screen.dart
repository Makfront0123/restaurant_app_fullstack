import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/category_list.dart';

import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/search_input.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';

import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/product_carousel_content.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_state.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SearchInput(category: category),
                  const SizedBox(height: 20),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductsLoadedByCategory) {
                        return BlocBuilder<SearchBloc, SearchState>(
                          builder: (context, searchState) {
                            return ProductCarouselContent(
                              stateFilter: (state) =>
                                  state is ProductsLoadedByCategory
                                      ? state
                                      : null,
                              productExtractor: (state) =>
                                  (state as ProductsLoadedByCategory).products,
                              isVertical: true,
                            );
                          },
                        );
                      } else if (state is ProductsError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
              if (searchState is SearchCategoryListVisibleState &&
                  searchState.showSidebar!) {
                final filteredProducts = searchState.products
                    .where((product) => product.category == category)
                    .toList();

                return _buildSidebarCategory(context, filteredProducts);
              }

              if (searchState is SearchNoResultsState) {
                return _buildNoResultsMessage(context);
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Positioned _buildSidebarCategory(
      BuildContext context, List<Product> filteredProducts) {
    return Positioned(
      top: 70,
      left: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          context.read<SearchBloc>().add(SearchHideCategoryList());
        },
        child: AuthContainer(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height,
          child: CategoryList(filteredProducts: filteredProducts),
        ),
      ),
    );
  }

  Positioned _buildNoResultsMessage(BuildContext context) {
    return Positioned(
      top: 70,
      left: 0,
      bottom: 0,
      child: AuthContainer(
        color: Colors.grey[300]!,
        width: MediaQuery.of(context).size.width * .7,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Text(
            'No se encontraron productos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
