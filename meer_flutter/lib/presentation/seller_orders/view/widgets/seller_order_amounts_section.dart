import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class SellerOrderAmountsSection extends StatelessWidget {
  final OrderInfo order;

  const SellerOrderAmountsSection({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final productsSubtotal = order.productsSubtotal ?? order.totalAmount;

    final isDelivery = order.fulfillmentMethod == 'delivery';

    Widget buildRow(String title, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      );
    }

    return Column(
      children: [
        buildRow(
          'قيمة المنتجات',
          '${productsSubtotal.toStringAsFixed(2)} ر.س',
        ),
        if (isDelivery) ...[
          const SizedBox(height: 10),
          buildRow(
            'رسوم التوصيل',
            order.deliveryFee == 0
                ? 'مجاني'
                : '${order.deliveryFee.toStringAsFixed(2)} ر.س',
          ),
        ],
        const SizedBox(height: 12),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'إجمالي الطلب',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${order.totalAmount.toStringAsFixed(2)} ر.س',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
