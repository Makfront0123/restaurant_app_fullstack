import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/form_input.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Row(
      children: [
        FormInput(searchController: searchController),
        const SizedBox(
          width: 10,
        ),
        Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            )),
      ],
    );
  }
}
