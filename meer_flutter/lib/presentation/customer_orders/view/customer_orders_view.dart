import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_card.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_empty.dart';

class CustomerOrdersView extends StatelessWidget {
  const CustomerOrdersView({
    super.key,
    required this.orders,
    required this.cancellingOrderIds,
    required this.onCancel,
    this.targetOrderId,
  });

  final List<OrderInfo> orders;
  final Set<int> cancellingOrderIds;
  final ValueChanged<int> onCancel;
  final int? targetOrderId;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return CustomerOrderEmpty();
    }

    // تقديم الطلب المستهدف دون تغيير بيانات القائمة الأصلية.
    final targetIndex = targetOrderId == null
        ? -1
        : orders.indexWhere(
            (order) => order.id == targetOrderId,
          );

    final displayOrders = targetIndex > 0
        ? [
            orders[targetIndex],
            ...orders.take(targetIndex),
            ...orders.skip(targetIndex + 1),
          ]
        : orders;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: displayOrders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = displayOrders[index];
        final orderId = order.id;

        return CustomerOrderCard(
          key: ValueKey('customer-order-$orderId'),
          order: order,
          isCancelling: orderId != null && cancellingOrderIds.contains(orderId),
          isHighlighted: targetOrderId != null && orderId == targetOrderId,
          onCancel: () {
            if (orderId != null) {
              onCancel(orderId);
            }
          },
        );
      },
    );
  }
}
