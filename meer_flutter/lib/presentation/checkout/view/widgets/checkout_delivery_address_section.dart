import 'package:flutter/material.dart';

class CheckoutDeliveryAddressSection extends StatelessWidget {
  final TextEditingController addressController;
  final bool hasLocation;
  final bool isLocating;
  final bool isSubmitting;
  final VoidCallback onUseCurrentLocation;
  final ValueChanged<String> onAddressChanged;

  const CheckoutDeliveryAddressSection({
    super.key,
    required this.addressController,
    required this.hasLocation,
    required this.isLocating,
    required this.isSubmitting,
    required this.onUseCurrentLocation,
    required this.onAddressChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
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
          enabled: !isSubmitting,
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
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: isSubmitting || isLocating ? null : onUseCurrentLocation,
            icon: isLocating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(
                    Icons.my_location,
                    size: 18,
                  ),
            label: Text(
              isLocating
                  ? 'جارٍ تحديد الموقع...'
                  : hasLocation
                  ? 'تحديث موقعي'
                  : 'استخدم موقعي الحالي',
            ),
          ),
        ),
      ],
    );
  }
}
