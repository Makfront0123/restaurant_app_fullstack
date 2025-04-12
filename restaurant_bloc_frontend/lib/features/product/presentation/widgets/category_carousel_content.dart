import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_state.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';

class CategoryCarouselContent extends StatelessWidget {
  final HomeState? Function(HomeState) stateFilter;
  final List<CategoryItem> Function(HomeState) categoryExtractor;
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
    return ProductCarousel<CategoryItem, HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>(),
      stateBuilder: (context, state) {
        print('STATE IN CAROUSEL: $state');
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return _buildCategoryList(context, state.categories);
        }
        return const Text("Error");
      },
    );
  }

  Widget _buildCategoryList(BuildContext context, List<CategoryItem> products) {
    return SizedBox(
      height: containerHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemBuilder: (context, index) {
          return _buildCategoryCard(context, products[index]);
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryItem category) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/menuCat', arguments: category.title);
      },
      child: Column(
        children: [
          Image.asset(category.image, height: 70),
          Text(category.title),
        ],
      ),
    );
  }
}
