import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class SellerOrderItemsSection extends StatelessWidget {
  const SellerOrderItemsSection({
    super.key,
    required this.items,
  });

  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المنتجات المطلوبة',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          const Text('لا توجد تفاصيل للمنتجات.')
        else
          ...items.map(
            (item) {
              final productName = item.product?.name ?? 'منتج غير معروف';

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.quantity} × '
                      '${item.price.toStringAsFixed(2)} ر.س',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
