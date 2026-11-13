import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    super.key,
    required this.items,
    required this.addressController,
    required this.formKey,
    required this.hasLocation,
    required this.isLocating,
    required this.onUseCurrentLocation,
    required this.phoneController,
    required this.codeController,
    required this.isPhoneVerified,
    required this.isSendingPhoneCode,
    required this.isPhoneCodeSent,
    required this.isVerifyingPhone,
    required this.onSendPhoneCode,
    required this.onVerifyPhone,
    required this.onAddressChanged,
  });

  final List<CartItem> items;
  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;
  final bool hasLocation;
  final bool isLocating;
  final VoidCallback onUseCurrentLocation;
  final TextEditingController phoneController;
  final TextEditingController codeController;

  final bool isPhoneVerified;
  final bool isSendingPhoneCode;
  final bool isPhoneCodeSent;
  final bool isVerifyingPhone;

  final VoidCallback onSendPhoneCode;
  final VoidCallback onVerifyPhone;
  final ValueChanged<String> onAddressChanged;

  double get totalAmount {
    return items.fold(
      0.0,
      (total, item) => total + item.product.price * item.quantity,
    );
  }

  bool _isValidSaudiPhone(String phone) {
    var value = phone.trim().replaceAll(RegExp(r'[\s\-()]'), '');

    value = value.replaceFirst(
      RegExp(r'^(?:\+?966|00966|0)+'),
      '',
    );

    return RegExp(r'^5\d{8}$').hasMatch(value);
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
              onChanged: onAddressChanged,
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
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  hasLocation
                      ? Icons.check_circle_outline
                      : Icons.location_searching,
                  size: 20,
                  color: hasLocation ? colors.primary : colors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    hasLocation
                        ? 'تم تحديد موقع التوصيل.'
                        : 'لم يتم تحديد موقع التوصيل بعد.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: isLocating ? null : onUseCurrentLocation,
                  icon: isLocating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location, size: 18),
                  label: Text(
                    hasLocation ? 'تحديث موقعي' : 'استخدم موقعي الحالي',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            Text(
              'رقم التواصل',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: phoneController,
              readOnly: isPhoneVerified,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                hintText: '05xxxxxxxx',
                prefixIcon: const Icon(Icons.phone_outlined),
                border: const OutlineInputBorder(),
                suffixIcon: isPhoneVerified
                    ? Icon(
                        Icons.verified,
                        color: colors.primary,
                      )
                    : null,
              ),
              validator: (value) {
                if (isPhoneVerified) return null;

                if (value == null || value.trim().isEmpty) {
                  return 'رقم الهاتف مطلوب.';
                }

                if (!_isValidSaudiPhone(value)) {
                  return 'أدخل رقم جوال سعودي صحيحًا.';
                }

                return 'يجب توثيق رقم الهاتف أولًا.';
              },
            ),

            if (isPhoneVerified) ...[
              const SizedBox(height: 8),
              Text(
                'تم توثيق رقم هاتفك بنجاح.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.primary,
                ),
              ),
            ] else ...[
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isSendingPhoneCode || isVerifyingPhone
                      ? null
                      : onSendPhoneCode,
                  icon: isSendingPhoneCode
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.sms_outlined),
                  label: Text(
                    isSendingPhoneCode
                        ? 'جارٍ إرسال الرمز...'
                        : isPhoneCodeSent
                        ? 'إعادة إرسال رمز التحقق'
                        : 'إرسال رمز التحقق',
                  ),
                ),
              ),

              if (isPhoneCodeSent) ...[
                const SizedBox(height: 16),

                TextFormField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  decoration: const InputDecoration(
                    labelText: 'رمز التحقق',
                    hintText: 'أدخل الرمز الذي وصلك',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: isVerifyingPhone ? null : onVerifyPhone,
                    icon: isVerifyingPhone
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.verified_outlined),
                    label: Text(
                      isVerifyingPhone ? 'جارٍ التحقق...' : 'توثيق رقم الهاتف',
                    ),
                  ),
                ),
              ],
            ],
            SizedBox(
              height: 28,
            ),
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
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: colors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الدفع والتوصيل',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'لا يتوفر الدفع الإلكتروني داخل مِيْر حاليًا. '
                            'بعد قبول الطلب، ستتواصل الأسرة معك لتأكيد طريقة الدفع '
                            'ورسوم التوصيل وموعد الاستلام أو التوصيل.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'رسوم التوصيل غير مشمولة في إجمالي المنتجات.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
