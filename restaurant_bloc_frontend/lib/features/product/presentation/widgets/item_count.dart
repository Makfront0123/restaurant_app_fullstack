import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class ItemCount extends StatefulWidget {
  final Axis direction;
  final Product product;

  const ItemCount({
    super.key,
    required this.product,
    this.direction = Axis.horizontal,
  });

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.product.productCount;
  }

  void _increment() {
    setState(() {
      _count++;
    });
    context.read<CartBloc>().add(UpdateProductCount(
          product: widget.product,
          count: _count,
        ));
  }

  void _decrement() {
    if (_count > 1) {
      setState(() {
        _count--;
      });
      context.read<CartBloc>().add(UpdateProductCount(
            product: widget.product,
            count: _count,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.direction == Axis.horizontal;
    final spacing =
        isHorizontal ? const SizedBox(width: 10) : const SizedBox(height: 10);

    return Flex(
      direction: widget.direction,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.only(top: 2),
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
        ),
        spacing,
        Text(
          _count.toString(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        spacing,
        IconButton(
          padding: const EdgeInsets.only(top: 2),
          icon: const Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
