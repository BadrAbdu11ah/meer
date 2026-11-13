import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/city_info.dart';

import 'seller_coordinates_section.dart';
import 'seller_setup_section.dart';

class SellerLocationSection extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController districtController;

  final MeerCity city;
  final ValueChanged<MeerCity> onCityChanged;

  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  final bool isSubmitting;
  final bool isLocating;

  final VoidCallback onUseCurrentLocation;

  const SellerLocationSection({
    super.key,
    required this.addressController,
    required this.districtController,
    required this.city,
    required this.onCityChanged,
    required this.latitudeController,
    required this.longitudeController,
    required this.isSubmitting,
    required this.isLocating,
    required this.onUseCurrentLocation,
  });

  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'عنوان الاستلام مطلوب.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SellerSetupSection(
      icon: Icons.location_on_outlined,
      title: 'موقع الأسرة',
      description: 'حدد المدينة والحي وموقع استلام الطلبات.',
      child: Column(
        children: [
          DropdownButtonFormField<MeerCity>(
            initialValue: city,
            decoration: const InputDecoration(
              labelText: 'المدينة',
              prefixIcon: Icon(Icons.location_city_outlined),
              border: OutlineInputBorder(),
            ),
            items: [
              for (final item in MeerCity.values)
                DropdownMenuItem(
                  value: item,
                  child: Text(item.label),
                ),
            ],
            onChanged: isSubmitting
                ? null
                : (value) {
                    if (value != null) {
                      onCityChanged(value);
                    }
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
              labelText: 'عنوان الاستلام من الأسرة',
              hintText: 'الموقع الذي سيستلم منه العميل طلبه',
              helperText:
                  'لن يظهر العنوان التفصيلي للعميل إلا بعد قبول طلب الاستلام.',
              prefixIcon: Icon(Icons.home_outlined),
              border: OutlineInputBorder(),
            ),
            validator: _validateAddress,
          ),
          SellerCoordinatesSection(
            latitudeController: latitudeController,
            longitudeController: longitudeController,
            isSubmitting: isSubmitting,
            isLocating: isLocating,
            onUseCurrentLocation: onUseCurrentLocation,
          ),
        ],
      ),
    );
  }
}
