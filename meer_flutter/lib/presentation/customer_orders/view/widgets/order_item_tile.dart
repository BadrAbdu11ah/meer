import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem item;

  const OrderItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lineTotal = item.price * item.quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(
            Icons.restaurant_outlined,
            color: Colors.grey,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.name ?? 'منتج #${item.productId}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.price.toStringAsFixed(2)} ر.س × ${item.quantity}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),

          Text(
            '${lineTotal.toStringAsFixed(2)} ر.س',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
