import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';
import 'package:restaurant_bloc_frontend/features/menu/presentation/widgets/menu_appbar.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_bloc.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_event.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/blocs/products_state.dart';
import 'package:restaurant_bloc_frontend/features/product/presentation/widgets/item_count.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late String? selectedProduct;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    if (args == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return;
    }
    selectedProduct = args;
    context.read<ProductsBloc>().add(LoadProduct(selectedProduct ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppbar(title: '',),
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductLoaded) {
          return _buildProductDetails(state);
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget _buildProductDetails(ProductLoaded state) {
    final product = state.product;
    final description = product.productDescription.substring(0, 150);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AuthContainer(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.all(40),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .45,
          child: Image.asset(state.product.image),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.productName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "${product.kcal.toString()}-${product.productWeight.toString()}gr",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                description,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 50),
              ItemCount(
                itemPrice: product.productPrice,
              ),
              SizedBox(height: 10),
              AuthButton(
                onTap: () {},
                text: 'Add to Cart',
              )
            ],
          ),
        ),
      ],
    );
  }
}
