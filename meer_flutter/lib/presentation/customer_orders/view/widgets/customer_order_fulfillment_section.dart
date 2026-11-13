import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class CustomerOrderFulfillmentSection extends StatelessWidget {
  final OrderInfo order;

  const CustomerOrderFulfillmentSection({
    super.key,
    required this.order,
  });

  bool get _isPickup => order.fulfillmentMethod == 'pickup';

  Widget _buildInfoBox({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isPickup) {
      final pickupAddress = order.pickupAddress?.trim();

      if (pickupAddress != null && pickupAddress.isNotEmpty) {
        return _buildInfoBox(
          context: context,
          icon: Icons.storefront_outlined,
          title: 'عنوان الاستلام من الأسرة',
          message: pickupAddress,
        );
      }

      return _buildInfoBox(
        context: context,
        icon: Icons.storefront_outlined,
        title: 'الاستلام من الأسرة',
        message: order.status == 'pending'
            ? 'سيظهر عنوان الاستلام هنا بعد قبول الأسرة للطلب.'
            : order.status == 'cancelled'
            ? 'لم يتم قبول الطلب.'
            : 'لم يتم تسجيل عنوان الاستلام لهذا الطلب.',
      );
    }

    final address = order.deliveryAddress?.trim();

    return _buildInfoBox(
      context: context,
      icon: Icons.delivery_dining_outlined,
      title: 'عنوان التوصيل',
      message: address == null || address.isEmpty
          ? 'لا يوجد عنوان توصيل مسجل.'
          : address,
    );
  }
}
