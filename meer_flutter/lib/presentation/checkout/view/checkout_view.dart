import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_delivery_address_section.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_fulfillment_section.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_payment_notice.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_phone_section.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_products_section.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_summary_section.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    super.key,
    required this.items,
    required this.addressController,
    required this.formKey,
    required this.fulfillmentMethod,
    required this.sellerOffersDelivery,
    required this.sellerDeliveryFee,
    required this.onFulfillmentMethodChanged,
    required this.hasLocation,
    required this.isLocating,
    required this.onUseCurrentLocation,
    required this.onAddressChanged,
    required this.phoneController,
    required this.codeController,
    required this.isPhoneVerified,
    required this.isSendingPhoneCode,
    required this.isPhoneCodeSent,
    required this.isVerifyingPhone,
    required this.isSubmitting,
    required this.onSendPhoneCode,
    required this.onVerifyPhone,
  });

  final List<CartItem> items;

  final TextEditingController addressController;
  final GlobalKey<FormState> formKey;

  // طريقة تنفيذ الطلب.
  final String fulfillmentMethod;
  final bool sellerOffersDelivery;
  final double sellerDeliveryFee;
  final ValueChanged<String> onFulfillmentMethodChanged;

  // موقع التوصيل.
  final bool hasLocation;
  final bool isLocating;
  final VoidCallback onUseCurrentLocation;
  final ValueChanged<String> onAddressChanged;

  // الهاتف والتحقق.
  final TextEditingController phoneController;
  final TextEditingController codeController;

  final bool isPhoneVerified;
  final bool isSendingPhoneCode;
  final bool isPhoneCodeSent;
  final bool isVerifyingPhone;
  final bool isSubmitting;

  final VoidCallback onSendPhoneCode;
  final VoidCallback onVerifyPhone;

  bool get isDelivery => fulfillmentMethod == 'delivery';

  int get totalQuantity {
    return items.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }

  double get productsSubtotal {
    final total = items.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );

    return double.parse(total.toStringAsFixed(2));
  }

  double get estimatedDeliveryFee {
    if (!isDelivery) return 0;

    return double.parse(
      sellerDeliveryFee.toStringAsFixed(2),
    );
  }

  double get estimatedTotal {
    return double.parse(
      (productsSubtotal + estimatedDeliveryFee).toStringAsFixed(2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. طريقة تنفيذ الطلب.
            CheckoutFulfillmentSection(
              fulfillmentMethod: fulfillmentMethod,
              sellerOffersDelivery: sellerOffersDelivery,
              sellerDeliveryFee: sellerDeliveryFee,
              isSubmitting: isSubmitting,
              onChanged: onFulfillmentMethodChanged,
            ),

            // 2. عنوان وموقع التوصيل.
            if (isDelivery) ...[
              const SizedBox(height: 24),
              CheckoutDeliveryAddressSection(
                addressController: addressController,
                hasLocation: hasLocation,
                isLocating: isLocating,
                isSubmitting: isSubmitting,
                onUseCurrentLocation: onUseCurrentLocation,
                onAddressChanged: onAddressChanged,
              ),
            ],

            // 3. رقم الهاتف والتحقق.
            const SizedBox(height: 28),
            CheckoutPhoneSection(
              phoneController: phoneController,
              codeController: codeController,
              isPhoneVerified: isPhoneVerified,
              isSendingPhoneCode: isSendingPhoneCode,
              isPhoneCodeSent: isPhoneCodeSent,
              isVerifyingPhone: isVerifyingPhone,
              isSubmitting: isSubmitting,
              onSendPhoneCode: onSendPhoneCode,
              onVerifyPhone: onVerifyPhone,
            ),

            // 4. مراجعة المنتجات.
            const SizedBox(height: 28),
            CheckoutProductsSection(
              items: items,
            ),

            // 5. ملخص المبالغ.
            const SizedBox(height: 16),
            CheckoutSummarySection(
              totalQuantity: totalQuantity,
              productsSubtotal: productsSubtotal,
              deliveryFee: estimatedDeliveryFee,
              totalAmount: estimatedTotal,
              isDelivery: isDelivery,
            ),

            // 6. معلومات الدفع.
            const SizedBox(height: 12),
            const CheckoutPaymentNotice(),
          ],
        ),
      ),
    );
  }
}
