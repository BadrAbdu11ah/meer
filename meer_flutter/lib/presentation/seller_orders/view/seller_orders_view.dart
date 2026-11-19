import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/routes/order_details_route_arguments.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_card.dart';

class SellerOrdersView extends StatelessWidget {
  const SellerOrdersView({
    super.key,
    required this.orders,
    this.targetOrderId,
    this.onRefreshRequested,
  });

  final List<OrderPresentation> orders;
  final int? targetOrderId;
  final Future<void> Function()? onRefreshRequested;

  @override
  Widget build(BuildContext context) {
    final Widget content;

    if (orders.isEmpty) {
      content = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(
            height: 350,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'لا توجد طلبات واردة حاليًا.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ستظهر طلبات عملائك هنا عند استلام طلب جديد.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
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

      content = ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: displayOrders.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final presentation = displayOrders[index];
          final orderId = presentation.order.id;

          return SellerOrderCard(
            key: ValueKey('seller-order-$orderId'),
            presentation: presentation,
            isHighlighted: orderId == targetOrderId,
            onTap: () {
              if (orderId == null) return;

              Navigator.of(context).pushNamed(
                AppRoute.orderDetailsScreen,
                arguments: OrderDetailsRouteArguments(
                  orderId: orderId,
                  isSellerView: true,
                ),
              );
            },
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefreshRequested?.call();
      },
      child: content,
    );
  }
}
