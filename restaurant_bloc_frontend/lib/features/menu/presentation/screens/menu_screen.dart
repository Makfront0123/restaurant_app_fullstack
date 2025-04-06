import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_state.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/search_input.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HomeAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SearchInput(),
                _buildMenuCarousel(context),
              ],
            ),
          ),
        ));
  }

  ProductCarousel<CategoryItem, HomeBloc, HomeState> _buildMenuCarousel(
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
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return _buildCategoryCard(index, categories);
        },
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(vertical: 40),
      ),
    );
  }

  Widget _buildCategoryCard(int index, List<CategoryItem> categories) {
    final queryH = MediaQuery.of(context).size.height;
    final queryW = MediaQuery.of(context).size.width;
    return HomeContainer(
      height: queryH * .4,
      width: queryW * .4,
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
