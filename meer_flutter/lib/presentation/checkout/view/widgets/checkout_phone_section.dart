import 'package:flutter/material.dart';

class CheckoutPhoneSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController codeController;

  final bool isPhoneVerified;
  final bool isSendingPhoneCode;
  final bool isPhoneCodeSent;
  final bool isVerifyingPhone;
  final bool isSubmitting;

  final VoidCallback onSendPhoneCode;
  final VoidCallback onVerifyPhone;

  const CheckoutPhoneSection({
    super.key,
    required this.phoneController,
    required this.codeController,
    required this.isPhoneVerified,
    required this.isSendingPhoneCode,
    required this.isPhoneCodeSent,
    required this.isVerifyingPhone,
    required this.isSubmitting,
    required this.onSendPhoneCode,
    required this.onVerifyPhone,
  });

  bool _isValidSaudiPhone(String phone) {
    var value = phone.trim().replaceAll(
      RegExp(r'[\s\-()]'),
      '',
    );

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'رقم التواصل',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: phoneController,
          enabled: !isSubmitting,
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
              onPressed: isSubmitting || isSendingPhoneCode || isVerifyingPhone
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
              enabled: !isSubmitting && !isVerifyingPhone,
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
                onPressed: isSubmitting || isVerifyingPhone
                    ? null
                    : onVerifyPhone,
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
      ],
    );
  }
}
