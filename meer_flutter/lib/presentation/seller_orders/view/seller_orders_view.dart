import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_card.dart';

class SellerOrdersView extends StatelessWidget {
  final Future<void> Function()? onRefreshRequested;

  final List<OrderInfo> orders;
  final Set<int> updatingOrderIds;
  final ValueChanged<int> onAccept;
  final ValueChanged<int> onReject;
  final ValueChanged<int> onMarkReady;
  final ValueChanged<int> onMarkCompleted;

  const SellerOrdersView({
    super.key,
    required this.orders,
    required this.updatingOrderIds,
    required this.onAccept,
    required this.onReject,
    required this.onMarkReady,
    required this.onMarkCompleted,
    this.onRefreshRequested,
  });

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
      content = ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          final orderId = order.id;

          return SellerOrderCard(
            order: order,
            isUpdating: orderId != null && updatingOrderIds.contains(orderId),
            onAccept: () {
              if (orderId != null) onAccept(orderId);
            },
            onReject: () {
              if (orderId != null) onReject(orderId);
            },
            onMarkReady: () {
              if (orderId != null) onMarkReady(orderId);
            },
            onMarkCompleted: () {
              if (orderId != null) {
                onMarkCompleted(orderId);
              }
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
