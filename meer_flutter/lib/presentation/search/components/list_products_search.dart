import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/shared/widgets/product_card.dart';

class ListProductsSearch extends StatelessWidget {
  final List<Product> products;

  const ListProductsSearch({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
        );
      },
    );
  }
}
