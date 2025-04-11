import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_state.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_carousel.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/review_carousel.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/title_button.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/product_carousel_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const HomeAppbar(), body: _buildHomeBody(context));
  }

  Widget _buildHomeBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeCarousel(),
          TitleButton(context: context, title: 'We offer'),
          _buildOfferCarousel(
            context,
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
          ),
          TitleButton(
            context: context,
            title: 'Our Happy Clients Say',
          ),
          const ReviewCarousel()
        ],
      ),
    );
  }

  ProductCarousel<CategoryItem, HomeBloc, HomeState> _buildOfferCarousel(
      BuildContext context) {
    return ProductCarousel<CategoryItem, HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>(),
      stateBuilder: (context, state) {
        if (state is HomeLoading) {
          return const CircularProgressIndicator();
        } else if (state is HomeLoaded) {
          return _buildCategoryList(context, state.categories);
        }
        return const Text("Error");
      },
    );
  }

  Widget _buildCategoryList(
      BuildContext context, List<CategoryItem> categories) {
    return SizedBox(
      height: 110,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            index,
            categories,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(int index, List<CategoryItem> categories) {
    return HomeContainer(
      height: 100,
      width: 100,
      onTap: () {
        Navigator.pushNamed(context, '/menuCat',
            arguments: categories[index].title);
      },
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
