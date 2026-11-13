import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class SellerOrderFulfillmentSection extends StatelessWidget {
  final OrderInfo order;

  const SellerOrderFulfillmentSection({
    super.key,
    required this.order,
  });

  bool get _isPickup => order.fulfillmentMethod == 'pickup';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final title = _isPickup ? 'استلام من الأسرة' : 'توصيل إلى العميل';

    final address = _isPickup
        ? order.pickupAddress?.trim()
        : order.deliveryAddress?.trim();

    final hasAddress = address != null && address.isNotEmpty;

    final message = hasAddress
        ? address
        : _isPickup
        ? order.status == 'pending'
              ? 'سيظهر عنوان الاستلام في الطلب بعد قبولك له.'
              : 'لم يتم تسجيل عنوان الاستلام لهذا الطلب.'
        : 'لم يسجل العميل عنوان التوصيل.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _isPickup
                ? Icons.storefront_outlined
                : Icons.delivery_dining_outlined,
            color: colors.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: hasAddress
                        ? colors.onSurface
                        : colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
