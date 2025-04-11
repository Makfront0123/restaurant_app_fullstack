import 'package:flutter/material.dart';

class ItemCount extends StatelessWidget {
  final Axis direction;

  const ItemCount({
    super.key,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final isHorizontal = direction == Axis.horizontal;
    final spacing =
        isHorizontal ? const SizedBox(width: 10) : const SizedBox(height: 10);

    return Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.remove_circle),
        spacing,
        Text(
          '1',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        spacing,
        const Icon(Icons.add_circle),
      ],
    );
  }
}
