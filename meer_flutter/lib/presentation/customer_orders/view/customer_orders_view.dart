import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/routes/order_details_route_arguments.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_card.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_empty.dart';

class CustomerOrdersView extends StatelessWidget {
  const CustomerOrdersView({
    super.key,
    required this.orders,
    this.targetOrderId,
  });

  final List<OrderPresentation> orders;
  final int? targetOrderId;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return CustomerOrderEmpty();
    }

    final targetIndex = targetOrderId == null
        ? -1
        : orders.indexWhere(
            (presentation) => presentation.order.id == targetOrderId,
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
        final presentation = displayOrders[index];
        final orderId = presentation.order.id;

        return CustomerOrderCard(
          key: ValueKey('customer-order-$orderId'),
          presentation: presentation,
          isHighlighted: targetOrderId != null && orderId == targetOrderId,
          onTap: () {
            if (orderId == null) return;

            Navigator.of(context).pushNamed(
              AppRoute.orderDetailsScreen,
              arguments: OrderDetailsRouteArguments(
                orderId: orderId,
                isSellerView: false,
              ),
            );
          },
        );
      },
    );
  }
}
