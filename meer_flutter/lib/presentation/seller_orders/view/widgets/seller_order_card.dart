import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_actions.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_amounts_section.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_delivery_section.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_fulfillment_section.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_items_section.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_status_badge.dart';

class SellerOrderCard extends StatelessWidget {
  const SellerOrderCard({
    super.key,
    required this.order,
    required this.isUpdating,
    required this.onAccept,
    required this.onReject,
    required this.onMarkReady,
    required this.onMarkCompleted,
  });

  final OrderInfo order;
  final bool isUpdating;

  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onMarkReady;
  final VoidCallback onMarkCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = order.items ?? <OrderItem>[];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(theme),
            const SizedBox(height: 8),

            SellerOrderDeliverySection(
              createdAt: order.createdAt,
            ),

            const SizedBox(height: 12),

            SellerOrderFulfillmentSection(
              order: order,
            ),
            const SizedBox(height: 12),

            const Divider(),

            SellerOrderItemsSection(items: items),

            const Divider(),

            SellerOrderAmountsSection(
              order: order,
            ),

            if (_hasActions) ...[
              const SizedBox(height: 16),
              SellerOrderActions(
                status: order.status,
                isUpdating: isUpdating,
                onAccept: onAccept,
                onReject: onReject,
                onMarkReady: onMarkReady,
                onMarkCompleted: onMarkCompleted,
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool get _hasActions {
    return order.status == 'pending' ||
        order.status == 'preparing' ||
        order.status == 'ready';
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'طلب رقم #${order.id ?? '-'}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SellerOrderStatusBadge(
          status: order.status,
          isUpdating: isUpdating,
        ),
      ],
    );
  }
}
