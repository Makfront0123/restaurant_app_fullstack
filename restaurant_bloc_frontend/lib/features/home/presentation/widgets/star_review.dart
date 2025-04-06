import 'package:flutter/material.dart';

class StarReview extends StatelessWidget {
  const StarReview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 16,
        ),
      ],
    );
  }
}
