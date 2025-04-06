import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Carousel genérico que funciona con cualquier Bloc y tipo de dato.
class ProductCarousel<T, B extends BlocBase<S>, S> extends StatefulWidget {
  final B bloc;

  final BlocWidgetBuilder<S> stateBuilder;

  final double height;
  final EdgeInsets padding;
  final double separatorWidth;

  const ProductCarousel({
    super.key,
    required this.bloc,
    required this.stateBuilder,
    this.height = 230,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    this.separatorWidth = 20,
  });

  @override
  State<ProductCarousel<T, B, S>> createState() =>
      _ProductCarouselState<T, B, S>();
}

class _ProductCarouselState<T, B extends BlocBase<S>, S>
    extends State<ProductCarousel<T, B, S>> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>.value(
      value: widget.bloc,
      child: BlocBuilder<B, S>(
        builder: widget.stateBuilder,
      ),
    );
  }
}

/*
class ProductCarousel extends StatefulWidget {
  const ProductCarousel({super.key});

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(LoadProductsData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProductsLoaded) {
          return _buildProductList(context, state.products);
        }
        return const SizedBox(child: Center(child: Text('Error')),);
      },
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductItem> products) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 20,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          itemBuilder: (context, index) {
            return _buildCategoryCard(products, index);
          }),
    );
  }

  Widget _buildCategoryCard(List<ProductItem> products, int index) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height;
    return HomeContainer(
        height: queryH * .5,
        width: queryW * .6,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                products[index].image,
                height: 130,
              ),
              Positioned(
                  bottom: 0,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(products[index].productName),
                      Row(
                        children: [
                          Text("\$${products[index].productPrice}"),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${products[index].productWeight}gr"),
                        ],
                      ),
                    ],
                  )),
              Positioned(
                  top: -15,
                  right: -5,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined))),
              Positioned(
                  bottom: -10,
                  right: 0,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_circle))),
            ],
          ),
        ));
  }
}

 */