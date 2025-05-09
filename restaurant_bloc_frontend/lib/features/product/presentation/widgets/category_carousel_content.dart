import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
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
    return ProductCarousel<CategoryItem, MenuBloc, MenuState>(
      // Cambio aquí
      bloc: context.read<MenuBloc>(),
      stateBuilder: (context, state) {
        if (state is MenuLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final filteredState = stateFilter(state);
          if (filteredState == null) {
            return const SizedBox.shrink();
          }

          final categories = categoryExtractor(filteredState);
          final categoryItems = categories
              .map((cat) => CategoryItem(
                    id: cat.id,
                    title: cat.title,
                    image: cat.image,
                  ))
              .toList();

          return _buildCategoryList(context, categoryItems);
        }
      },
    );
  }

  Widget _buildCategoryList(
      BuildContext context, List<CategoryItem> categories) {
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

  Widget _buildCategoryCard(BuildContext context, CategoryItem category) {
    const String baseUrl = 'http://10.0.2.2:3000/';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/menuCat', arguments: category.id);
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
