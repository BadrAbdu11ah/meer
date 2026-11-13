import 'package:flutter/material.dart';

class CheckoutSummarySection extends StatelessWidget {
  final int totalQuantity;
  final double productsSubtotal;
  final double deliveryFee;
  final double totalAmount;
  final bool isDelivery;

  const CheckoutSummarySection({
    super.key,
    required this.totalQuantity,
    required this.productsSubtotal,
    required this.deliveryFee,
    required this.totalAmount,
    required this.isDelivery,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('عدد القطع'),
                Text('$totalQuantity'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('قيمة المنتجات'),
                Text(
                  '${productsSubtotal.toStringAsFixed(2)} ر.س',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('رسوم التوصيل'),
                Text(
                  isDelivery
                      ? deliveryFee == 0
                            ? 'مجاني'
                            : '${deliveryFee.toStringAsFixed(2)} ر.س'
                      : 'لا توجد (استلام من الأسرة)',
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي التقديري',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(2)} ر.س',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'هذا إجمالي تقديري. يتحقق الخادم من أسعار المنتجات '
              'ورسوم التوصيل قبل إنشاء الطلب.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
