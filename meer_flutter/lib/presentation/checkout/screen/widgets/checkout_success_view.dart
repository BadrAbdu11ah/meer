import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class CheckoutSuccessView extends StatelessWidget {
  final OrderInfo order;
  final VoidCallback onBack;

  const CheckoutSuccessView({
    super.key,
    required this.order,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isPickup = order.fulfillmentMethod == 'pickup';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('تم تأكيد الطلب'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: colors.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'تم استلام طلبك بنجاح',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                isPickup
                    ? 'سيظهر عنوان الاستلام في تفاصيل طلبك بعد قبول الأسرة للطلب.'
                    : 'يمكنك متابعة حالة التوصيل من طلباتك داخل مِيْر.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text('رقم الطلب: ${order.id}'),
              const SizedBox(height: 8),
              Text(
                'الإجمالي: ${order.totalAmount.toStringAsFixed(2)} ر.س',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onBack,
                  child: const Text('العودة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
