import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    super.key,
    required this.items,
    required this.addressController,
    required this.formKey,
  });

  final List<CartItem> items;
  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;

  double get totalAmount {
    return items.fold(
      0.0,
      (total, item) => total + item.product.price * item.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'عنوان التوصيل',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: addressController,
              minLines: 2,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'أدخل عنوان التوصيل بالتفصيل...',
                prefixIcon: Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'عنوان التوصيل مطلوب.';
                }

                return null;
              },
            ),
            const SizedBox(height: 28),
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
                    '${item.product.price.toStringAsFixed(2)} ر.س × ${item.quantity}',
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
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('عدد القطع'),
                        Text(
                          '${items.fold<int>(0, (sum, item) => sum + item.quantity)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الإجمالي المبدئي',
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
                    const SizedBox(height: 8),
                    Text(
                      'سيتم اعتماد الأسعار النهائية بعد التحقق منها في الخادم. رسوم التوصيل غير مشمولة.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
