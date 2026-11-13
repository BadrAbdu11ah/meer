import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:meer_flutter/presentation/checkout/screen/widgets/checkout_empty_cart_view.dart';
import 'package:meer_flutter/presentation/checkout/screen/widgets/checkout_failure_view.dart';
import 'package:meer_flutter/presentation/checkout/screen/widgets/checkout_loading_view.dart';
import 'package:meer_flutter/presentation/checkout/screen/widgets/checkout_submit_bar.dart';
import 'package:meer_flutter/presentation/checkout/screen/widgets/checkout_success_view.dart';
import 'package:meer_flutter/presentation/checkout/view/checkout_view.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  CheckoutReady? _lastReadyState;

  @override
  void initState() {
    super.initState();

    final cartItems = context.read<CartBloc>().state.items;

    if (cartItems.isNotEmpty) {
      final sellerId = cartItems.first.product.sellerId;

      context.read<CheckoutBloc>().add(
        CheckoutEvent.started(sellerId: sellerId),
      );
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // Phone verification
  // --------------------------------------------------

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

  void _sendPhoneCode() {
    final phone = _phoneController.text.trim();

    if (!_isValidSaudiPhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('أدخل رقم جوال سعودي صحيحًا.'),
        ),
      );
      return;
    }

    context.read<CheckoutBloc>().add(
      CheckoutEvent.phoneCodeRequested(phone: phone),
    );
  }

  void _verifyPhone() {
    final code = _codeController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('أدخل رمز التحقق الذي وصلك.'),
        ),
      );
      return;
    }

    context.read<CheckoutBloc>().add(
      CheckoutEvent.phoneVerificationSubmitted(
        phone: _phoneController.text.trim(),
        code: code,
      ),
    );
  }

  // --------------------------------------------------
  // Checkout actions
  // --------------------------------------------------

  void _submitOrder() {
    final currentState = context.read<CheckoutBloc>().state;

    final readyState = currentState is CheckoutReady
        ? currentState
        : _lastReadyState;

    if (readyState == null) return;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final cartItems = context.read<CartBloc>().state.items;

    if (cartItems.isEmpty) return;

    final isDelivery = readyState.fulfillmentMethod == 'delivery';

    context.read<CheckoutBloc>().add(
      CheckoutEvent.submitted(
        items: cartItems,
        deliveryAddress: isDelivery ? _addressController.text.trim() : null,
        latitude: isDelivery ? readyState.latitude : null,
        longitude: isDelivery ? readyState.longitude : null,
      ),
    );
  }

  void _changeFulfillmentMethod(String method) {
    context.read<CheckoutBloc>().add(
      CheckoutEvent.fulfillmentMethodChanged(method: method),
    );
  }

  void _onAddressChanged(String address) {
    context.read<CheckoutBloc>().add(
      CheckoutEvent.addressChanged(address: address),
    );
  }

  void _requestCurrentLocation() {
    context.read<CheckoutBloc>().add(
      const CheckoutEvent.locationRequested(),
    );
  }

  // --------------------------------------------------
  // Bloc listener
  // --------------------------------------------------

  void _onCheckoutStateChanged(
    BuildContext context,
    CheckoutState state,
  ) {
    if (state is CheckoutReady) {
      _lastReadyState = state;

      if (state.address != null && _addressController.text.isEmpty) {
        _addressController.text = state.address!;
      }

      if (state.phone.isNotEmpty &&
          (state.isPhoneVerified || _phoneController.text.isEmpty)) {
        _phoneController.text = state.phone;
      }

      if (state.isPhoneVerified) {
        _codeController.clear();
      }

      final message = state.errorMessage;

      if (message != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
      }
    }

    if (state is CheckoutSuccess) {
      context.read<CartBloc>().add(
        const CartEvent.cleared(),
      );
    }
  }

  // --------------------------------------------------
  // Build
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: _onCheckoutStateChanged,
      builder: (context, state) {
        if (state is CheckoutSuccess) {
          return CheckoutSuccessView(
            order: state.order,
            onBack: () => Navigator.of(context).pop(),
          );
        }

        return BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (cartState.isEmpty) {
              return const CheckoutEmptyCartView();
            }

            if (state is CheckoutInitial) {
              return const CheckoutLoadingView();
            }

            if (state is CheckoutFailure) {
              return CheckoutFailureView(
                message: state.message,
                onBack: () => Navigator.of(context).pop(),
              );
            }

            final readyState = state is CheckoutReady ? state : _lastReadyState;

            if (readyState == null) {
              return const CheckoutLoadingView();
            }

            final isSubmitting = state is CheckoutSubmitting;
            final isLocating = state is CheckoutLocating;

            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'إتمام الطلب',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: CheckoutView(
                items: cartState.items,
                addressController: _addressController,
                phoneController: _phoneController,
                codeController: _codeController,
                formKey: _formKey,

                fulfillmentMethod: readyState.fulfillmentMethod,
                sellerOffersDelivery: readyState.sellerOffersDelivery,
                sellerDeliveryFee: readyState.sellerDeliveryFee,
                onFulfillmentMethodChanged: _changeFulfillmentMethod,

                hasLocation:
                    readyState.latitude != null && readyState.longitude != null,
                isLocating: isLocating,
                onUseCurrentLocation: _requestCurrentLocation,
                onAddressChanged: _onAddressChanged,

                isPhoneVerified: readyState.isPhoneVerified,
                isSendingPhoneCode: readyState.isSendingPhoneCode,
                isPhoneCodeSent: readyState.isPhoneCodeSent,
                isVerifyingPhone: readyState.isVerifyingPhone,
                isSubmitting: isSubmitting,
                onSendPhoneCode: _sendPhoneCode,
                onVerifyPhone: _verifyPhone,
              ),
              bottomNavigationBar: CheckoutSubmitBar(
                isSubmitting: isSubmitting,
                onSubmit: _submitOrder,
              ),
            );
          },
        );
      },
    );
  }
}
