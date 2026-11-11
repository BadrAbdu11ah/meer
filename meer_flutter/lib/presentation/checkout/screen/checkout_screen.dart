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
    super.dispose();
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
        state.whenOrNull(
          ready: (address, latitude, longitude) {
            setState(() {
              if (address != null &&
                  address.trim().isNotEmpty &&
                  _addressController.text.trim().isEmpty) {
                _addressController.text = address;
              }

              _latitude = latitude;
              _longitude = longitude;
            });
          },
          success: (_) {
            // تفريغ السلة بعد أن يؤكد الخادم إنشاء الطلب.
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
                          formKey: _formKey,
                          hasLocation: _latitude != null && _longitude != null,
                          isLocating: isLocating,
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
