import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/item_count.dart';

class ItemProductCount extends StatefulWidget {
  const ItemProductCount({super.key, required this.product});
  final ProductItem product;
  @override
  State<ItemProductCount> createState() => _ItemProductCountState();
}

class _ItemProductCountState extends State<ItemProductCount> {
  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${widget.product.productPrice}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            ItemCount(direction: Axis.horizontal, product: widget.product)
          ],
        ),
      ),
    );
  }
}
