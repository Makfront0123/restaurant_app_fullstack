import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/application/presentation/widgets/load_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_event.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_state.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  void _getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    if (token.isNotEmpty) {
      if (!mounted) return;
      context.read<FavoriteBloc>().add(FavoriteEventGetFavorite(token: token));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token no encontrado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(
        title: 'Favorites',
        showUser: false,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          final isLoading = state is FavoriteLoading;
          print('FavoriteState is $state');

          if (state is FavoriteError) {
            return const Center(child: CircularProgressIndicator());
          }

          return LoadScreen(
            isLoading: isLoading,
            child: Builder(
              builder: (context) {
                if (state is FavoritegetLoaded) {
                  final products =
                      state.products; // Aquí obtienes la lista de productos

                  return products.isEmpty
                      ? const ScreenEmpty(
                          emptyImage: Vectors.favorite,
                          title: 'Your Favorites is empty',
                        )
                      : _buildFavoriteContent(products);
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteContent(List<Product> products) {
    const String baseUrl = 'http://10.0.2.2:3000/';
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final product = products[index];

        return AuthContainer(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Image.network('$baseUrl${product.image}', height: 100),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.productName),
                      Row(
                        children: [
                          Text("\$${product.productPrice}"),
                          const SizedBox(width: 10),
                          Text("${product.productWeight}gr"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
