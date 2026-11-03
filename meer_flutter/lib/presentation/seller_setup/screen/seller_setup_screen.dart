import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/seller_setup/bloc/seller_setup_bloc.dart';
import 'package:meer_flutter/presentation/seller_setup/view/seller_setup_view.dart';

class SellerSetupScreen extends StatefulWidget {
  const SellerSetupScreen({super.key});

  @override
  State<SellerSetupScreen> createState() => _SellerSetupScreenState();
}

class _SellerSetupScreenState extends State<SellerSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _storeNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
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
        title: const Text(
          'إعداد المتجر',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<SellerSetupBloc, SellerSetupState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: colors.error,
                ),
              );
            },
            success: (profile) {
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

          return SellerSetupView(
            formKey: _formKey,
            storeNameController: _storeNameController,
            descriptionController: _descriptionController,
            addressController: _addressController,
            latitudeController: _latitudeController,
            longitudeController: _longitudeController,
            isSubmitting: isSubmitting,
            onSubmit: _submit,
          );
        },
      ),
    );
  }
}
