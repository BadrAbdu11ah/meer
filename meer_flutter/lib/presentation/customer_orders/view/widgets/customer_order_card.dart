import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/order_item_tile.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/order_status_tracker.dart';

class CustomerOrderCard extends StatelessWidget {
  const CustomerOrderCard({
    super.key,
    required this.order,
    required this.isCancelling,
    required this.onCancel,
  });

  final OrderInfo order;
  final bool isCancelling;
  final VoidCallback onCancel;

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

  Future<void> _confirmCancel(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إلغاء الطلب'),
        content: Text(
          'هل أنت متأكد من إلغاء الطلب رقم #${order.id}؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('رجوع'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      onCancel();
    }
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
            if (order.status == 'pending') ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isCancelling
                      ? null
                      : () => _confirmCancel(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.error,
                  ),
                  icon: isCancelling
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.cancel_outlined),
                  label: Text(
                    isCancelling ? 'جارٍ إلغاء الطلب...' : 'إلغاء الطلب',
                  ),
                ),
              ),
            ],
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
