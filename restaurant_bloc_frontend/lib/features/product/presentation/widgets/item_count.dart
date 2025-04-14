import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ItemCount extends StatelessWidget {
  final Axis direction;
  final Product product;

  const ItemCount({
    super.key,
    required this.product,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.only(top: 2),
          icon: const Icon(Icons.remove),
          onPressed: () {
            context
                .read<CartBloc>()
                .add(DecrementProductCount(product: product));
          },
        ),
        spacing,
        Text(
          product.productCount.toString(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        spacing,
        IconButton(
          padding: const EdgeInsets.only(top: 2),
          icon: const Icon(Icons.add),
          onPressed: () {
            context
                .read<CartBloc>()
                .add(IncrementProductCount(product: product));
          },
        ),
      ],
    );
  }
}
