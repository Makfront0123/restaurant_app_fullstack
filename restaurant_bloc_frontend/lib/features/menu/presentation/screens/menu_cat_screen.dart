import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/product_carousel.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/search_input.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';

class MenuCatScreen extends StatefulWidget {
  const MenuCatScreen({super.key});

  @override
  State<MenuCatScreen> createState() => _MenuCatScreenState();
}

class _MenuCatScreenState extends State<MenuCatScreen> {
  late String? selectedCategory; // Almacena la categoría seleccionada

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recibe el argumento (categoría seleccionada)
    final args = ModalRoute.of(context)?.settings.arguments as String?;

    if (args == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context); // Vuelve si no hay categoría
      });
      return;
    }

    selectedCategory = args;
    print('Categoría seleccionada: $selectedCategory'); // Debug
    // Dispara el evento para cargar productos de esta categoría
    context.read<ProductsBloc>().add(LoadProductsByCategory(selectedCategory??''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MenuAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SearchInput(),
              const SizedBox(height: 70),
              _buildCatMenuCarousel(context),
            ],
          ),
        ));
  }

  ProductCarousel<ProductItem, ProductsBloc, ProductsState>
      _buildCatMenuCarousel(BuildContext context) {
    return ProductCarousel<ProductItem, ProductsBloc, ProductsState>(
      bloc: context.read<ProductsBloc>(),
      stateBuilder: (context, state) {
        print("PRODUCT Current state: $state");
        if (state is ProductsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProductsLoadedByCategory) {
          return _buildProductList(context, state.products);
        }
        return const Text("Error");
      },
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductItem> products) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) => _buildCategoryCard(products, index),
      ),
    );
  }

  Widget _buildCategoryCard(List<ProductItem> products, int index) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height;
    return HomeContainer(
        height: queryH * .3,
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
