import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:restaurant_bloc_frontend/features/cart/presentation/blocs/cart_event.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';

class ProductCarouselContent extends StatelessWidget {
  final ProductsState? Function(ProductsState) stateFilter;
  final List<Product> Function(ProductsState) productExtractor;
  final double? containerHeight;
  final bool isVertical;

  const ProductCarouselContent({
    super.key,
    required this.stateFilter,
    required this.productExtractor,
    this.containerHeight,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return ProductCarousel<Product, ProductsBloc, ProductsState>(
      bloc: context.read<ProductsBloc>(),
      stateBuilder: (context, state) {
        if (state is ProductsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProductsLoaded ||
            state is ProductsLoadedByCategory) {
          final products = state is ProductsLoaded
              ? state.products
              : (state as ProductsLoadedByCategory).products;

          return _buildProductList(context, products);
        }

        return const Text("Error");
      },
    );
  }

  Widget _buildProductList(BuildContext context, List<Product> products) {
    if (products.isEmpty) {
      return SizedBox(
        height: containerHeight ?? MediaQuery.of(context).size.height,
        child: const Center(
          child: Text(
            'No hay productos disponibles 😔',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    return SizedBox(
      height: containerHeight ?? MediaQuery.of(context).size.height,
      child: ListView.separated(
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) =>
            isVertical ? const SizedBox(height: 20) : const SizedBox(width: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemBuilder: (context, index) {
          return _buildCard(context, products[index], isVertical: isVertical);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Product product,
      {bool isVertical = false}) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height;
    final height = isVertical ? queryH * .3 : queryH * .5;
    const String baseUrl = 'http://10.0.2.2:3000/';

    return HomeContainer(
      height: height,
      width: queryW * .6,
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.network('$baseUrl${product.image}', height: 130),
            Positioned(
              bottom: 0,
              left: 20,
              child: Column(
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
            Positioned(
              top: -15,
              right: -5,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_outlined)),
            ),
            Positioned(
              bottom: -10,
              right: 0,
              child: IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(
                        AddProductToCart(product: product),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 1),
                        content: Text('${product.productName} added to cart')),
                  );
                },
                icon: const Icon(Icons.add_circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
