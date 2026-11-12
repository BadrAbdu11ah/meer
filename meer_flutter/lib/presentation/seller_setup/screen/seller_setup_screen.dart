import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/seller_setup/bloc/seller_setup_bloc.dart';
import 'package:meer_flutter/presentation/seller_setup/view/seller_setup_view.dart';

class SellerSetupScreen extends StatefulWidget {
  const SellerSetupScreen({
    super.key,
    this.initialProfile,
  });

  /// عند تمريره تعمل الشاشة في وضع تعديل بيانات الأسرة الحالية.
  final MeerUserProfile? initialProfile;

  bool get isEditing => initialProfile != null;

  @override
  State<SellerSetupScreen> createState() => _SellerSetupScreenState();
}

class _SellerSetupScreenState extends State<SellerSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _storeNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _districtController = TextEditingController();
  MeerCity _city = MeerCity.madinah;
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final profile = widget.initialProfile;

    if (profile != null) {
      _storeNameController.text = profile.storeName ?? '';
      _descriptionController.text = profile.storeDescription ?? '';
      _addressController.text = profile.storeAddress ?? '';
      _districtController.text = profile.storeDistrict ?? '';
      _city = profile.storeCity ?? MeerCity.madinah;
      _latitudeController.text = profile.storeLatitude?.toString() ?? '';
      _longitudeController.text = profile.storeLongitude?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _districtController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<SellerSetupBloc>().add(
      SellerSetupEvent.submitted(
        storeName: _storeNameController.text.trim(),
        storeDescription: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        storeAddress: _addressController.text.trim(),
        city: _city,
        district: _districtController.text.trim().isEmpty
            ? null
            : _districtController.text.trim(),
        latitude: double.parse(
          _latitudeController.text.trim(),
        ),
        longitude: double.parse(
          _longitudeController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'تعديل بيانات الأسرة' : 'إعداد المتجر',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<SellerSetupBloc, SellerSetupState>(
        listener: (context, state) {
          state.whenOrNull(
            locationFound: (latitude, longitude) {
              _latitudeController.text = latitude.toStringAsFixed(6);
              _longitudeController.text = longitude.toStringAsFixed(6);
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: colors.error,
                ),
              );
            },
            success: (profile) {
              if (widget.isEditing) {
                // وضع التعديل: نرجع لشاشة الحساب.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم حفظ بيانات الأسرة.'),
                  ),
                );
                Navigator.pop(context, true);
                return;
              }

              Navigator.pushReplacementNamed(
                context,
                AppRoute.sellerProductsScreen,
              );
            },
          );
        },
        builder: (context, state) {
          final isSubmitting = state.maybeWhen(
            submitting: () => true,
            orElse: () => false,
          );

          final isLocating = state.maybeWhen(
            locating: () => true,
            orElse: () => false,
          );

          return SellerSetupView(
            formKey: _formKey,
            storeNameController: _storeNameController,
            descriptionController: _descriptionController,
            addressController: _addressController,
            districtController: _districtController,
            city: _city,
            onCityChanged: (city) => setState(() => _city = city),
            latitudeController: _latitudeController,
            longitudeController: _longitudeController,
            isSubmitting: isSubmitting,
            isEditing: widget.isEditing,
            isLocating: isLocating,
            onUseCurrentLocation: () {
              context.read<SellerSetupBloc>().add(
                const SellerSetupEvent.locationRequested(),
              );
            },
            onSubmit: _submit,
          );
        },
      ),
    );
  }
}
