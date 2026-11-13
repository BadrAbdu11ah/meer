import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/checkout/bloc/checkout_bloc.dart';
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

  // موقع التوصيل (من الموقع الحالي، ولاحقًا من الخريطة).
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(const CheckoutEvent.started());
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  bool _isValidSaudiPhone(String phone) {
    var value = phone.trim().replaceAll(RegExp(r'[\s\-()]'), '');

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

  void _submitOrder() {
    if (!_formKey.currentState!.validate()) return;

    final cartItems = context.read<CartBloc>().state.items;

    if (cartItems.isEmpty) return;

    context.read<CheckoutBloc>().add(
      CheckoutEvent.submitted(
        items: cartItems,
        deliveryAddress: _addressController.text,
        latitude: _latitude,
        longitude: _longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutReady) {
          _lastReadyState = state;

          if (state.address != null &&
              state.address!.trim().isNotEmpty &&
              _addressController.text.trim().isEmpty) {
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

        state.whenOrNull(
          success: (_) {
            context.read<CartBloc>().add(
              const CartEvent.cleared(),
            );
          },
          failure: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
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

        final readyState = state is CheckoutReady ? state : _lastReadyState;

        return state.maybeWhen(
          success: (order) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('تم تأكيد الطلب'),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'تم استلام طلبك بنجاح',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'ستتواصل الأسرة معك على رقم هاتفك الموثّق '
                        'لتأكيد طريقة الدفع ورسوم التوصيل وتفاصيل التسليم.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Text('رقم الطلب: ${order.id}'),
                      const SizedBox(height: 8),
                      Text(
                        'الإجمالي: ${order.totalAmount.toStringAsFixed(2)} ر.س',
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('العودة إلى السلة'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          orElse: () {
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'إتمام الطلب',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: cartState.isEmpty
                      ? const Center(
                          child: Text('السلة فارغة.'),
                        )
                      : CheckoutView(
                          items: cartState.items,
                          addressController: _addressController,
                          phoneController: _phoneController,
                          codeController: _codeController,
                          isPhoneVerified: readyState?.isPhoneVerified ?? false,
                          isSendingPhoneCode:
                              readyState?.isSendingPhoneCode ?? false,
                          isPhoneCodeSent: readyState?.isPhoneCodeSent ?? false,
                          isVerifyingPhone:
                              readyState?.isVerifyingPhone ?? false,
                          onSendPhoneCode: _sendPhoneCode,
                          onVerifyPhone: _verifyPhone,
                          formKey: _formKey,
                          hasLocation: _latitude != null && _longitude != null,
                          isLocating: isLocating,
                          onAddressChanged: (_) {
                            _latitude = null;
                            _longitude = null;
                          },
                          onUseCurrentLocation: () {
                            context.read<CheckoutBloc>().add(
                              const CheckoutEvent.locationRequested(),
                            );
                          },
                        ),
                  bottomNavigationBar: cartState.isEmpty
                      ? null
                      : SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: FilledButton.icon(
                              onPressed: isSubmitting ? null : _submitOrder,
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
                                isSubmitting
                                    ? 'جارٍ إرسال الطلب...'
                                    : 'تأكيد الطلب',
                              ),
                            ),
                          ),
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}
