import 'package:flutter/material.dart';

class SellerProductsEmptyState extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colors;
  const SellerProductsEmptyState({
    super.key,
    required this.theme,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 56,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد منتجات في متجرك بعد.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'ستظهر منتجاتك هنا بعد إضافتها.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
