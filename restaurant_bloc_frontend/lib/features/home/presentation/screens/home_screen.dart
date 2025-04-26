import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_carousel.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_drawer.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/review_carousel.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/title_button.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/category_carousel_content.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/product_carousel_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
      body: _buildHomeBody(context),
      drawer: const HomeDrawer(),
    );
  }

  Widget _buildHomeBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeCarousel(),
          TitleButton(context: context, title: 'We offer'),
          CategoryCarouselContent(
            isVertical: false,
            stateFilter: (state) =>
                state is MenuLoaded || state is MenuFiltered ? state : null,
            categoryExtractor: (state) {
              if (state is MenuLoaded) {
                return state.categories;
              } else if (state is MenuFiltered) {
                return state.filteredCategories;
              }
              return [];
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            child: Text(
              'Recommend for you',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ProductCarouselContent(
            stateFilter: (state) => state is ProductsLoaded ? state : null,
            productExtractor: (state) => (state as ProductsLoaded).products,
            containerHeight: 230,
          ),
          TitleButton(
            context: context,
            title: 'Our Happy Clients Say',
          ),
          const ReviewCarousel(),
        ],
      ),
    );
  }
}
