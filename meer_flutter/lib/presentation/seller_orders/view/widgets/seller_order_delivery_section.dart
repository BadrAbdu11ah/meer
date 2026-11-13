import 'package:flutter/material.dart';

class SellerOrderDeliverySection extends StatelessWidget {
  const SellerOrderDeliverySection({
    super.key,
    required this.createdAt,
    required this.deliveryAddress,
  });

  final DateTime createdAt;
  final String deliveryAddress;

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();

    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');

    return '$day/$month/${localDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاريخ الطلب: ${_formatDate(createdAt)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'عنوان التوصيل',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          deliveryAddress,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
