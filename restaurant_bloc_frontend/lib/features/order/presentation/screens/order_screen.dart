import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(
        showUser: false,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.isOrder) {
            return const Center(
              child: Text('Order'),
            );
          } else {
            return const ScreenEmpty(
                emptyImage: Vectors.favorite, title: 'Your Order is Empty');
          }
        },
      ),
    );
  }
}
