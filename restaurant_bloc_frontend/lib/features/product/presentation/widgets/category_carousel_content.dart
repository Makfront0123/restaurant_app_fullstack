import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';
import 'package:restaurant_bloc_frontend/features/menu/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_blocs.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_state.dart';

class CategoryCarouselContent extends StatelessWidget {
  final MenuState? Function(MenuState) stateFilter;
  final List<Category> Function(MenuState) categoryExtractor;
  final double containerHeight;
  final bool isVertical;

  const CategoryCarouselContent({
    super.key,
    required this.stateFilter,
    required this.categoryExtractor,
    this.containerHeight = 130,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProductCarousel<Category, MenuBloc, MenuState>(
      bloc: context.read<MenuBloc>(),
      stateBuilder: (context, state) {
        if (state is MenuLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MenuLoaded) {
          final categories = state.categories;
          print('categories: $categories');
          return _buildCategoryList(context, categories);
        }
        return const Text("Error");
      },
    );
  }

  Widget _buildCategoryList(BuildContext context, List<Category> categories) {
    return SizedBox(
      height: containerHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemBuilder: (context, index) {
          return _buildCategoryCard(context, categories[index]);
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category category) {
    const String baseUrl = 'http://10.0.2.2:3000/';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/menuCat', arguments: category.title);
      },
      child: Column(
        children: [
          Image.network('$baseUrl${category.image}', height: 70),
          Text(category.title),
        ],
      ),
    );
  }
}
