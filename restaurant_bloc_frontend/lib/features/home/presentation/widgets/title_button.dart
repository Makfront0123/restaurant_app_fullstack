import 'package:flutter/material.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({
    super.key,
    required this.context,
    required this.title,
  });

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'View all',
                style: Theme.of(context).textTheme.headlineSmall,
              ))
        ],
      ),
    );
  }
}
