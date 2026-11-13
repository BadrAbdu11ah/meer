import 'package:flutter/material.dart';

class SellerCoordinatesSection extends StatelessWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  final bool isSubmitting;
  final bool isLocating;

  final VoidCallback onUseCurrentLocation;

  const SellerCoordinatesSection({
    super.key,
    required this.latitudeController,
    required this.longitudeController,
    required this.isSubmitting,
    required this.isLocating,
    required this.onUseCurrentLocation,
  });

  String? _validateLatitude(String? value) {
    final number = double.tryParse(value?.trim() ?? '');

    if (number == null || !number.isFinite || number < -90 || number > 90) {
      return 'أدخل خط عرض صحيحًا بين -90 و90.';
    }

    return null;
  }

  String? _validateLongitude(String? value) {
    final number = double.tryParse(value?.trim() ?? '');

    if (number == null || !number.isFinite || number < -180 || number > 180) {
      return 'أدخل خط طول صحيحًا بين -180 و180.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 32),
        const Text(
          'إحداثيات الموقع',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          'يمكنك تحديد موقع الأسرة تلقائيًا أو إدخال الإحداثيات يدويًا.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: isSubmitting || isLocating ? null : onUseCurrentLocation,
          icon: isLocating
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.my_location),
          label: Text(
            isLocating ? 'جارٍ تحديد الموقع...' : 'استخدم موقعي الحالي',
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: latitudeController,
          enabled: !isSubmitting,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'خط العرض Latitude',
            hintText: 'مثال: 24.5247',
            border: OutlineInputBorder(),
          ),
          validator: _validateLatitude,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: longitudeController,
          enabled: !isSubmitting,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          decoration: const InputDecoration(
            labelText: 'خط الطول Longitude',
            hintText: 'مثال: 39.5692',
            border: OutlineInputBorder(),
          ),
          validator: _validateLongitude,
        ),
      ],
    );
  }
}
