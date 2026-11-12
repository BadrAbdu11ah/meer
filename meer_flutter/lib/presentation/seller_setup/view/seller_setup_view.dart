import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/city_info.dart';

class SellerSetupView extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController storeNameController;
  final TextEditingController descriptionController;
  final TextEditingController addressController;
  final TextEditingController districtController;
  final MeerCity city;
  final ValueChanged<MeerCity> onCityChanged;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  final bool isSubmitting;
  final bool isEditing;
  final bool isLocating;
  final VoidCallback onUseCurrentLocation;
  final VoidCallback onSubmit;

  const SellerSetupView({
    super.key,
    required this.formKey,
    required this.storeNameController,
    required this.descriptionController,
    required this.addressController,
    required this.districtController,
    required this.city,
    required this.onCityChanged,
    required this.latitudeController,
    required this.longitudeController,
    required this.isSubmitting,
    required this.isEditing,
    required this.isLocating,
    required this.onUseCurrentLocation,
    required this.onSubmit,
  });

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب.';
    }

    return null;
  }

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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Icon(
            Icons.storefront_outlined,
            size: 64,
            color: colors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'ابدأ البيع في مِيْر',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أكمل بيانات أسرتك المنتجة لتتمكن من عرض منتجاتك.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),

          TextFormField(
            controller: storeNameController,
            enabled: !isSubmitting,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'اسم الأسرة أو المتجر',
              hintText: 'مثال: أكلات أسرة مِيْر',
              prefixIcon: Icon(Icons.store_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) => _validateRequired(value, 'اسم المتجر'),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: descriptionController,
            enabled: !isSubmitting,
            maxLines: 3,
            maxLength: 300,
            decoration: const InputDecoration(
              labelText: 'نبذة عن المتجر (اختياري)',
              hintText: 'ما الأطعمة التي تقدمها أسرتك؟',
              prefixIcon: Icon(Icons.description_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<MeerCity>(
            initialValue: city,
            decoration: const InputDecoration(
              labelText: 'المدينة',
              prefixIcon: Icon(Icons.location_city_outlined),
              border: OutlineInputBorder(),
            ),
            items: [
              for (final item in MeerCity.values)
                DropdownMenuItem(value: item, child: Text(item.label)),
            ],
            onChanged: isSubmitting
                ? null
                : (value) {
                    if (value != null) onCityChanged(value);
                  },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: districtController,
            enabled: !isSubmitting,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'الحي (اختياري)',
              prefixIcon: Icon(Icons.map_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: addressController,
            enabled: !isSubmitting,
            maxLines: 2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'عنوان المتجر',
              hintText: 'العنوان المناسب للاستلام',
              prefixIcon: Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) => _validateRequired(value, 'عنوان المتجر'),
          ),
          const SizedBox(height: 20),

          Text(
            'إحداثيات موقع المتجر',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'إذا كنت الآن في مكان الأسرة، اضغط «استخدم موقعي الحالي» لتعبئة الإحداثيات تلقائيًا. ويمكنك إدخالها يدويًا. وسنضيف اختيار الموقع من الخريطة لاحقًا.',
            style: theme.textTheme.bodySmall?.copyWith(
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
          const SizedBox(height: 12),

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
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'خط الطول Longitude',
              hintText: 'مثال: 39.5692',
              border: OutlineInputBorder(),
            ),
            validator: _validateLongitude,
          ),
          const SizedBox(height: 24),

          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: isSubmitting ? null : onSubmit,
              child: isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      isEditing ? 'حفظ التعديلات' : 'حفظ البيانات وتفعيل البيع',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
