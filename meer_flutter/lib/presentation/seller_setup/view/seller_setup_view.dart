import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/seller_setup/view/widgets/seller_delivery_section.dart';
import 'package:meer_flutter/presentation/seller_setup/view/widgets/seller_location_section.dart';
import 'package:meer_flutter/presentation/seller_setup/view/widgets/seller_profile_section.dart';
import 'package:meer_flutter/presentation/seller_setup/view/widgets/seller_setup_header.dart';

class SellerSetupView extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  // بيانات الأسرة.
  final TextEditingController storeNameController;
  final TextEditingController descriptionController;

  // الموقع.
  final TextEditingController addressController;
  final TextEditingController districtController;

  final dynamic city;
  final ValueChanged<dynamic> onCityChanged;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;

  // التوصيل.
  final bool offersDelivery;
  final TextEditingController deliveryFeeController;
  final ValueChanged<bool> onOffersDeliveryChanged;

  // حالة الشاشة.
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
    required this.offersDelivery,
    required this.deliveryFeeController,
    required this.onOffersDeliveryChanged,
    required this.isSubmitting,
    required this.isEditing,
    required this.isLocating,
    required this.onUseCurrentLocation,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SellerSetupHeader(isEditing: isEditing),
          const SizedBox(height: 24),

          SellerProfileSection(
            storeNameController: storeNameController,
            descriptionController: descriptionController,
            isSubmitting: isSubmitting,
          ),
          const SizedBox(height: 16),

          SellerLocationSection(
            addressController: addressController,
            districtController: districtController,
            city: city,
            onCityChanged: onCityChanged,
            latitudeController: latitudeController,
            longitudeController: longitudeController,
            isSubmitting: isSubmitting,
            isLocating: isLocating,
            onUseCurrentLocation: onUseCurrentLocation,
          ),
          const SizedBox(height: 16),

          SellerDeliverySection(
            offersDelivery: offersDelivery,
            deliveryFeeController: deliveryFeeController,
            onOffersDeliveryChanged: onOffersDeliveryChanged,
            isSubmitting: isSubmitting,
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
