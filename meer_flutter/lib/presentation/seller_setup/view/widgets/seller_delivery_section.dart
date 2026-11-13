import 'package:flutter/material.dart';

import 'seller_setup_section.dart';

class SellerDeliverySection extends StatelessWidget {
  final bool offersDelivery;
  final TextEditingController deliveryFeeController;
  final ValueChanged<bool> onOffersDeliveryChanged;
  final bool isSubmitting;

  const SellerDeliverySection({
    super.key,
    required this.offersDelivery,
    required this.deliveryFeeController,
    required this.onOffersDeliveryChanged,
    required this.isSubmitting,
  });

  String? _validateDeliveryFee(String? value) {
    final number = double.tryParse(value?.trim() ?? '');

    if (number == null || !number.isFinite || number < 0) {
      return 'أدخل رسوم توصيل صحيحة، ولا يمكن أن تكون سالبة.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SellerSetupSection(
      icon: Icons.local_shipping_outlined,
      title: 'خيارات تنفيذ الطلب',
      description:
          'الاستلام من الأسرة متاح دائمًا. ويمكنك أيضًا توفير خدمة التوصيل.',
      child: Column(
        children: [
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'الأسرة توفر خدمة التوصيل',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text(
              'يمكن للعميل اختيار التوصيل بدلًا من الاستلام.',
            ),
            value: offersDelivery,
            onChanged: isSubmitting ? null : onOffersDeliveryChanged,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: offersDelivery
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      controller: deliveryFeeController,
                      enabled: !isSubmitting,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'رسوم التوصيل للعميل',
                        hintText: 'مثال: 15',
                        suffixText: 'ر.س',
                        prefixIcon: Icon(Icons.delivery_dining_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateDeliveryFee,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
