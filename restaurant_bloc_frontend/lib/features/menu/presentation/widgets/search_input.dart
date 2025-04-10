import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_bloc.dart';
import 'package:restaurant_bloc_frontend/features/search/presentation/blocs/search_event.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final text = _controller.text;
      context.read<SearchBloc>().add(SearchQueryChanged(text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Buscar categoría...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.filter_list_alt, color: Colors.white),
        ),
      ],
    );
  }
}


/*
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

 */