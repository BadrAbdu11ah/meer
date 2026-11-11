import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/order_item_tile.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/order_status_tracker.dart';

class CustomerOrderCard extends StatelessWidget {
  const CustomerOrderCard({
    super.key,
    required this.order,
  });

  final OrderInfo order;

  String _statusLabel(String status) {
    return switch (status) {
      'pending' => 'بانتظار قبول الأسرة',
      'preparing' => 'قيد التجهيز',
      'ready' => 'طلبك جاهز',
      'delivering' => 'جارٍ التوصيل',
      'completed' => 'مكتمل',
      'cancelled' => 'تم إلغاء الطلب',
      _ => 'حالة الطلب: $status',
    };
  }

  Color _statusColor(
    String status,
    ColorScheme colors,
  ) {
    return switch (status) {
      'pending' => colors.tertiary,
      'preparing' => colors.primary,
      'ready' => colors.secondary,
      'delivering' => colors.primary,
      'completed' => Colors.green,
      'cancelled' => colors.error,
      _ => colors.onSurfaceVariant,
    };
  }

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();

    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');

    return '$day/$month/${localDate.year} - $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final statusColor = _statusColor(order.status, colors);
    final items = order.items ?? const <OrderItem>[];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رقم الطلب والتاريخ.
            Row(
              children: [
                Expanded(
                  child: Text(
                    'طلب رقم #${order.id ?? '-'}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.grey,
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              _formatDate(order.createdAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            // حالة الطلب.
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _statusLabel(order.status),
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // مسار متابعة الطلب.
            OrderStatusTracker(status: order.status),

            const SizedBox(height: 16),
            const Divider(),

            // الإجمالي.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'إجمالي الطلب',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${order.totalAmount.toStringAsFixed(2)} ر.س',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            // تفاصيل المنتجات والعنوان.
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              collapsedBackgroundColor: Colors.grey[300],
              title: Text(
                'تفاصيل الطلب (${items.length} منتجات)',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'تعذر تحميل تفاصيل المنتجات.',
                    ),
                  )
                else
                  ...items.map(
                    (item) => OrderItemTile(item: item),
                  ),

                const Divider(),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.location_on_outlined,
                  ),
                  title: const Text('عنوان التوصيل'),
                  subtitle: Text(order.deliveryAddress),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
