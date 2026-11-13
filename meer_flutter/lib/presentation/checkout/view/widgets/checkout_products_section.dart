import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';

class CheckoutProductsSection extends StatelessWidget {
  final List<CartItem> items;

  const CheckoutProductsSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مراجعة المنتجات',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.restaurant_outlined),
              title: Text(
                item.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${item.product.price.toStringAsFixed(2)} ر.س × '
                '${item.quantity}',
              ),
              trailing: Text(
                '${(item.product.price * item.quantity).toStringAsFixed(2)} ر.س',
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
