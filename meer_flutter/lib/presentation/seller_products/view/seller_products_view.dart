import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/seller_products/view/widgets/seller_product_card.dart';
import 'package:meer_flutter/presentation/seller_products/view/widgets/seller_products_empty_state.dart';

class SellerProductsView extends StatelessWidget {
  final List<Product> products;
  final Set<int> updatingProductIds;
  final ValueChanged<Product> onEdit;
  final ValueChanged<int> onDeleteRequested;
  final void Function(int productId, bool isAvailable) onAvailabilityChanged;

  const SellerProductsView({
    super.key,
    required this.products,
    required this.updatingProductIds,
    required this.onAvailabilityChanged,
    required this.onEdit,
    required this.onDeleteRequested,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (products.isEmpty) {
      return SellerProductsEmptyState(theme: theme, colors: colors);
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final product = products[index];
        final isUpdating =
            product.id != null && updatingProductIds.contains(product.id);

        return SellerProductCard(
          product: product,
          theme: theme,
          colors: colors,
          isUpdating: isUpdating,
          onAvailabilityChanged: onAvailabilityChanged,
          onEdit: onEdit,
          onDeleteRequested: onDeleteRequested,
        );
      },
    );
  }
}
