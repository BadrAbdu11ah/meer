import 'package:flutter/material.dart';

class OrderStatusTracker extends StatelessWidget {
  const OrderStatusTracker({
    super.key,
    required this.status,
    required this.fulfillmentMethod,
  });

  final String status;
  final String fulfillmentMethod;

  bool get _isPickup => fulfillmentMethod == 'pickup';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (status == 'cancelled') {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.cancel_outlined,
              color: colors.error,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'تم إلغاء هذا الطلب.',
                style: TextStyle(
                  color: colors.onErrorContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final steps = _isPickup
        ? [
            (
              title: 'تم استلام الطلب',
              description: 'تم إرسال طلبك بنجاح.',
            ),
            (
              title: 'قيد التجهيز',
              description: 'الأسرة تعمل على تجهيز طلبك.',
            ),
            (
              title: 'جاهز للاستلام',
              description: 'يمكنك استلام طلبك من موقع الأسرة.',
            ),
            (
              title: 'تم الاستلام',
              description: 'تم تأكيد استلامك للطلب.',
            ),
          ]
        : [
            (
              title: 'تم استلام الطلب',
              description: 'تم إرسال طلبك بنجاح.',
            ),
            (
              title: 'قيد التجهيز',
              description: 'الأسرة تعمل على تجهيز طلبك.',
            ),
            (
              title: 'جاهز للتوصيل',
              description: 'اكتمل تجهيز طلبك وأصبح جاهزًا للتوصيل.',
            ),
            (
              title: 'جارٍ التوصيل',
              description: 'طلبك في طريقه إليك.',
            ),
            (
              title: 'تم التسليم',
              description: 'تم تأكيد تسليم الطلب.',
            ),
          ];

    final currentIndex = switch (status) {
      'pending' => 0,
      'preparing' => 1,
      'ready' => 2,
      'delivering' when !_isPickup => 3,
      'completed' => steps.length - 1,
      _ => -1,
    };

    if (currentIndex == -1) {
      return const SizedBox.shrink();
    }

    return Column(
      children: List.generate(steps.length, (index) {
        final isCompleted = status == 'completed' || index < currentIndex;

        final isCurrent = status != 'completed' && index == currentIndex;

        final isActive = isCompleted || isCurrent;

        final color = isActive ? colors.primary : colors.outlineVariant;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  Icon(
                    isCompleted
                        ? Icons.check_circle
                        : isCurrent
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 22,
                    color: color,
                  ),
                  if (index != steps.length - 1)
                    Container(
                      width: 2,
                      height: 28,
                      color: isCompleted
                          ? colors.primary
                          : colors.outlineVariant,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index].title,
                      style: TextStyle(
                        fontWeight: isCurrent
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isActive
                            ? colors.onSurface
                            : colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      steps[index].description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
