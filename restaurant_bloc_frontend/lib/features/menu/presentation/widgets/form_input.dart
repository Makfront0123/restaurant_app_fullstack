import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Search',
            constraints: const BoxConstraints(maxWidth: 100),
            labelStyle: Theme.of(context).textTheme.labelMedium,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 5, right: 8),
              child: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            )),
      ),
    );
  }
}