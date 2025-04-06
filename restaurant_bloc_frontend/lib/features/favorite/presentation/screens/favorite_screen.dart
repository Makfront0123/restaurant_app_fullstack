import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_bloc.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/blocs/favorite_state.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(
        showUser: false,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.isFavorite) {
            return const Center(
              child: Text('Favorite'),
            );
          } else {
            return const ScreenEmpty(
              emptyImage: Vectors.favorite,
              title: 'Your Favorite List is Empty',
            );
          }
        },
      ),
    );
  }
}
