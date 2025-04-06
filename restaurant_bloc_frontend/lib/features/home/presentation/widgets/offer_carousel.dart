import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_state.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({
    super.key,
  });

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const CircularProgressIndicator();
        } else if (state is HomeLoaded) {
          return _buildCategoryList(context, state.categories);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCategoryList(
      BuildContext context, List<CategoryItem> categories) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 20,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          itemBuilder: (context, index) {
            return _buildCategoryCard(index, categories);
          }),
    );
  }

  Widget _buildCategoryCard(int index, List<CategoryItem> categories) {
    return HomeContainer(
      height: 100,
      width: 100,
      onTap: () {},
      child: Stack(children: [
        Positioned.fill(
          top: -50,
          right: 0,
          child: Image.asset(categories[index].image),
        ),
        Positioned(
          bottom: 7,
          left: 7,
          child: Text(categories[index].title),
        ),
      ]),
    );
  }
}
