import 'package:flutter/material.dart';

class CheckoutSubmitBar extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const CheckoutSubmitBar({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: isSubmitting ? null : onSubmit,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
          ),
          icon: isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.check_circle_outline),
          label: Text(
            isSubmitting ? 'جارٍ إرسال الطلب...' : 'تأكيد الطلب',
          ),
        ),
      ),
    );
  }
}
