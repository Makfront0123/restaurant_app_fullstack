// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_bloc.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _controller = TextEditingController();
  late Product product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)?.settings.arguments as Product;
  }

  void onReview() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    if (_controller.text.isNotEmpty) {
      context.read<ReviewsBloc>().add(CreateReviewEvent(
            productId: product.id,
            author: product.productName,
            comment: _controller.text,
            token: token,
          ));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("¡Gracias por tu reseña!"),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Completa todos los campos para enviar tu reseña."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reseña del producto")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.productName,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            const Text("Tu calificación:"),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "¿Qué te pareció?",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onReview,
              child: const Text("Enviar reseña"),
            )
          ],
        ),
      ),
    );
  }
}
