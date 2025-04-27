import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/application/presentation/widgets/load_screen.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/favorite/presentation/widget/screen_empty.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_appbar.dart';
import 'package:restaurant_bloc_frontend/features/order/domain/models/order_item.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_bloc.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_event.dart';
import 'package:restaurant_bloc_frontend/features/order/presentation/blocs/order_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(
        showUser: false,
        title: 'Orders',
      ),
      body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
        final isLoading = state is OrderLoading;

        if (state is OrderFailed) {
          return const Center(child: CircularProgressIndicator());
        }

        return LoadScreen(
          isLoading: isLoading,
          child: Builder(
            builder: (context) {
              if (state is OrderByUser) {
                final orders = state.orders;
                return orders.isEmpty
                    ? const ScreenEmpty(
                        emptyImage: Vectors.favorite,
                        title: 'Your Order is Empty',
                      )
                    : _buildOrderContent(orders);
              }

              return const SizedBox.shrink();
            },
          ),
        );
      }),
    );
  }

  void _getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    // ignore: use_build_context_synchronously
    context.read<OrderBloc>().add(GetOrderEvent(token: token));
  }

  _buildOrderContent(List<Order> orders) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return AuthContainer(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListTile(
              title: Text('Order #${order.id} - \$${order.totalPrice}'),
              subtitle: Text('Status: ${order.status}'),
            ),
          );
        },
      ),
    );
  }
}




/*

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(
        showUser: false,
        title: 'Orders',
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderByUser) {
            final orders = state.orders;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return AuthContainer(
                    padding: const EdgeInsets.all(16),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListTile(
                      title: Text('Order #${order.id} - \$${order.totalPrice}'),
                      subtitle: Text('Status: ${order.status}'),
                    ),
                  );
                },
              ),
            );
          } else if (state is OrderCreating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderFailed) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const ScreenEmpty(
              emptyImage: Vectors.favorite,
              title: 'Your Order is Empty',
            );
          }
        },
      ),
    );
  }

  void _getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    // ignore: use_build_context_synchronously
    context.read<OrderBloc>().add(GetOrderEvent(token: token));
  }
}
 */