import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/shared/widgets/product_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.favorite_border,
                size: 64,
                color: colors.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              const Text(
                'قائمة المفضلة فارغة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'احفظ المنتجات التي تعجبك لتجدها هنا لاحقًا.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

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
        final product = products[index];

        return ProductCard(
          product: product,
          isFavorite: true,
          onFavoriteTap: () {
            context.read<FavoritesBloc>().add(
              FavoritesEvent.productToggled(
                product: product,
              ),
            );
          },
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoute.productDetailsScreen,
              arguments: product,
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
