import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';

class ItemCount extends StatefulWidget {
  const ItemCount({super.key, this.itemPrice});
  final double? itemPrice;
  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
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
              "\$${widget.itemPrice}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Row(
              children: [
                const Icon(Icons.remove),
                const SizedBox(width: 10),
                Text(
                  '1',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(width: 10),
                const Icon(Icons.add),
              ],
            )
          ],
        ),
      ),
    );
  }
}
