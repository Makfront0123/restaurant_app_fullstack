import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_blocs.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/blocs/menu_state.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_state.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
        appBar: const HomeAppbar(),
        body: _buildMenuContent(context, state),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (state is SearchHideCategoryList) {
              context.read<SearchBloc>().add(SearchShowCategoryList());
            } else if (state is SearchShowCategoryList) {
              context.read<SearchBloc>().add(SearchHideCategoryList());
            }
          },
          child: const Icon(Icons.filter_list),
        ),
      );
    });
  }

  SizedBox _buildMenuContent(BuildContext context, SearchState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildMenuCarousel(context),
            ),
          ),
        ],
      ),
    );
  }

  ProductCarousel<CategoryItem, MenuBloc, MenuState> _buildMenuCarousel(
      BuildContext context) {
    return ProductCarousel<CategoryItem, MenuBloc, MenuState>(
      bloc: context.read<MenuBloc>(),
      stateBuilder: (context, state) {
        if (state is MenuLoading) {
          return const CircularProgressIndicator();
        } else if (state is MenuLoaded) {
          final categoryItems = state.categories
              .map((cat) => CategoryItem(
                    id: cat.id,
                    title: cat.title,
                    image: cat.image,
                  ))
              .toList();

          return _buildCategoryList(context, categoryItems);
        }
        return const Text("Error al cargar categorías");
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
    const String baseUrl = 'http://10.0.2.2:3000/';

    final catId = categories[index].id;

    return HomeContainer(
      height: queryH * .4,
      width: queryW * .4,
      onTap: () {
        Navigator.pushNamed(context, '/menuCat', arguments: catId);
      },
      child: Stack(children: [
        Positioned.fill(
          top: -50,
          right: 0,
          child: Image.network('$baseUrl${categories[index].image}'),
        ),
        Positioned(
          bottom: 7,
          left: 7,
          child: Text(
            categories[index].title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ]),
    );
  }
}
