import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/category_item.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_state.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchCategoryListVisibleState) {
          return _buildSearchCategoryList(state.categories, context);
        } else if (state is SearchCategoryListHiddenState) {
          return const SizedBox.shrink();
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSearchCategoryList(
      List<CategoryItem> categories, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .9,
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 30),
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/menuCat',
                  arguments: categories[index].title);
            },
            child: ListTile(
              leading: Image.asset(category.image),
              title: Text(category.title),
            ),
          );
        },
      ),
    );
  }
}
