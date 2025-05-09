import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/form_input.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key, this.category});
  final String? category;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FormInput(searchController: searchController),
        const SizedBox(width: 10),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<SearchBloc>().add(SearchQueryChanged(
                  searchController.text, widget.category ?? ''));
            },
          ),
        ),
      ],
    );
  }
}
