import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/routes/product_details_route_arguments.dart';
import 'package:meer_flutter/presentation/shared/widgets/product_card.dart';

class ListProductsSearch extends StatelessWidget {
  final List<ProductPresentation> products;

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
        final presentation = products[index];
        final product = presentation.product;

        return ProductCard(
          product: product,
          sellerName: presentation.sellerName,
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoute.productDetailsScreen,
              arguments: ProductDetailsRouteArguments(
                product: product,
                sellerName: presentation.sellerName,
              ),
            );
          },
          onSellerTap: () {
            Navigator.of(context).pushNamed(
              AppRoute.sellerDetailsScreen,
              arguments: product.sellerId,
            );
          },
        );
      },
    );
  }
}
