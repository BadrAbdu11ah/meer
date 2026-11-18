import 'dart:async';

import 'package:flutter/material.dart';

class CheckoutPhoneSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController codeController;

  final bool isPhoneVerified;
  final bool isSendingPhoneCode;
  final bool isPhoneCodeSent;

  /// وقت آخر إرسال ناجح للرمز. كل قيمة جديدة تعيد بدء مهلة إعادة الإرسال.
  final DateTime? codeSentAt;

  final bool isVerifyingPhone;
  final bool isSubmitting;

  final VoidCallback onSendPhoneCode;
  final VoidCallback onVerifyPhone;

  /// مصدر الوقت الحالي، ويُستبدل في الاختبارات بساعة وهمية.
  final DateTime Function() now;

  const CheckoutPhoneSection({
    super.key,
    required this.phoneController,
    required this.codeController,
    required this.isPhoneVerified,
    required this.isSendingPhoneCode,
    required this.isPhoneCodeSent,
    required this.codeSentAt,
    required this.isVerifyingPhone,
    required this.isSubmitting,
    required this.onSendPhoneCode,
    required this.onVerifyPhone,
    this.now = DateTime.now,
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
          _SendCodeButton(
            isSending: isSendingPhoneCode,
            isCodeSent: isPhoneCodeSent,
            codeSentAt: codeSentAt,
            now: now,
            isDisabled: isSubmitting || isVerifyingPhone,
            onPressed: onSendPhoneCode,
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

/// زر إرسال الرمز مع مهلة قبل السماح بإعادة الإرسال.
///
/// المهلة للعرض فقط وليست حماية: الخادم هو من يقرر قبول الطلب، وقد يرفضه
/// بعد انتهاء المهلة أيضًا (حدود الرقم والعنوان والحد العام).
class _SendCodeButton extends StatefulWidget {
  const _SendCodeButton({
    required this.isSending,
    required this.isCodeSent,
    required this.codeSentAt,
    required this.now,
    required this.isDisabled,
    required this.onPressed,
  });

  final bool isSending;
  final bool isCodeSent;
  final DateTime? codeSentAt;
  final DateTime Function() now;
  final bool isDisabled;
  final VoidCallback onPressed;

  @override
  State<_SendCodeButton> createState() => _SendCodeButtonState();
}

class _SendCodeButtonState extends State<_SendCodeButton> {
  static const _cooldown = Duration(seconds: 60);

  Timer? _timer;
  int _secondsLeft = 0;

  @override
  void initState() {
    super.initState();
    _restartCooldown();
  }

  @override
  void didUpdateWidget(covariant _SendCodeButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // كل إرسال ناجح يحمل وقتًا جديدًا، فتبدأ المهلة من جديد. إعادة البناء
    // لأي سبب آخر لا تغيّر الوقت، فلا تؤثر على العدّ.
    if (widget.codeSentAt != oldWidget.codeSentAt) {
      _restartCooldown();
    }
  }

  /// الثواني المتبقية محسوبة من وقت الإرسال الفعلي، لا من عدّاد محلي، حتى
  /// يبقى العدّ صحيحًا لو أُعيد إنشاء الزر أو تأخر المؤقت.
  int _remainingSeconds() {
    final sentAt = widget.codeSentAt;

    if (sentAt == null) return 0;

    final remaining = sentAt.add(_cooldown).difference(widget.now());

    if (remaining <= Duration.zero) return 0;

    final seconds = (remaining.inMilliseconds / 1000).ceil();

    // لا تتجاوز المهلة مدتها حتى لو تغيّرت ساعة الجهاز.
    return seconds > _cooldown.inSeconds ? _cooldown.inSeconds : seconds;
  }

  void _restartCooldown() {
    _timer?.cancel();
    _timer = null;
    _secondsLeft = _remainingSeconds();

    if (_secondsLeft == 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final secondsLeft = _remainingSeconds();

      if (secondsLeft == 0) {
        timer.cancel();
        _timer = null;
      }

      if (secondsLeft != _secondsLeft) {
        setState(() => _secondsLeft = secondsLeft);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCoolingDown = _secondsLeft > 0;

    final label = widget.isSending
        ? 'جارٍ إرسال الرمز...'
        : isCoolingDown
        ? 'إعادة الإرسال بعد $_secondsLeft ث'
        : widget.isCodeSent
        ? 'إعادة إرسال رمز التحقق'
        : 'إرسال رمز التحقق';

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: widget.isDisabled || widget.isSending || isCoolingDown
            ? null
            : widget.onPressed,
        icon: widget.isSending
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.sms_outlined),
        label: Text(label),
      ),
    );
  }
}
