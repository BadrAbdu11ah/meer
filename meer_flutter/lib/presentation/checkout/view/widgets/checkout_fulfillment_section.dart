import 'package:flutter/material.dart';

class CheckoutFulfillmentSection extends StatelessWidget {
  final String fulfillmentMethod;
  final bool sellerOffersDelivery;
  final double sellerDeliveryFee;
  final bool isSubmitting;
  final ValueChanged<String> onChanged;

  const CheckoutFulfillmentSection({
    super.key,
    required this.fulfillmentMethod,
    required this.sellerOffersDelivery,
    required this.sellerDeliveryFee,
    required this.isSubmitting,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'طريقة استلام الطلب',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'اختر الطريقة المناسبة لاستلام طلبك.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),

            RadioGroup<String>(
              groupValue: fulfillmentMethod,
              onChanged: (value) {
                if (!isSubmitting && value != null) {
                  onChanged(value);
                }
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'pickup',
                    enabled: !isSubmitting,
                    contentPadding: EdgeInsets.zero,
                    activeColor: colors.primary,
                    title: const Text(
                      'الاستلام من الأسرة',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      'تستلم طلبك من موقع الأسرة بعد قبول الطلب.',
                    ),
                    secondary: const Icon(Icons.storefront_outlined),
                  ),

                  if (sellerOffersDelivery) ...[
                    const Divider(),
                    RadioListTile<String>(
                      value: 'delivery',
                      enabled: !isSubmitting,
                      contentPadding: EdgeInsets.zero,
                      activeColor: colors.primary,
                      title: const Text(
                        'التوصيل إلى موقعي',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        sellerDeliveryFee == 0
                            ? 'التوصيل مجاني.'
                            : 'رسوم التوصيل: '
                                  '${sellerDeliveryFee.toStringAsFixed(2)} ر.س',
                      ),
                      secondary: const Icon(
                        Icons.delivery_dining_outlined,
                      ),
                    ),
                  ] else ...[
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.info_outline,
                        color: colors.onSurfaceVariant,
                      ),
                      title: const Text('التوصيل غير متاح'),
                      subtitle: const Text(
                        'هذه الأسرة توفر الاستلام من موقعها فقط.',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
