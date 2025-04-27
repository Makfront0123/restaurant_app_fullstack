import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/product/domain/entities/product_item.dart';

class CategoryList extends StatelessWidget {
  final List<Product> filteredProducts;

  const CategoryList({super.key, required this.filteredProducts});

  @override
  Widget build(BuildContext context) {
    if (filteredProducts.isEmpty) {
      return const Center(child: Text('No se encontraron productos'));
    }

    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .9,
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 30),
        shrinkWrap: true,
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          const String baseUrl = 'http://10.0.2.2:3000/';
          final product = filteredProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product', arguments: product);
            },
            child: ListTile(
              leading: Image.network('$baseUrl${product.image}',
                  width: 50, height: 50),
              title: Text(product.productName),
            ),
          );
        },
      ),
    );
  }
}
