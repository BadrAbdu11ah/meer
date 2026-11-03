import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class SellerOrderCard extends StatelessWidget {
  const SellerOrderCard({
    super.key,
    required this.order,
    required this.isUpdating,
    required this.onAccept,
    required this.onReject,
    required this.onMarkReady,
  });

  final OrderInfo order;
  final bool isUpdating;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onMarkReady;

  String get _statusLabel {
    return switch (order.status) {
      'pending' => 'طلب جديد',
      'preparing' => 'قيد التجهيز',
      'ready' => 'جاهز للتوصيل',
      'delivering' => 'جارٍ التوصيل',
      'completed' => 'مكتمل',
      'cancelled' => 'ملغي',
      _ => order.status,
    };
  }

  Color _statusColor(ColorScheme colors) {
    return switch (order.status) {
      'pending' => colors.tertiary,
      'preparing' => colors.primary,
      'ready' => Colors.green,
      'delivering' => colors.secondary,
      'completed' => Colors.green,
      'cancelled' => colors.error,
      _ => colors.onSurfaceVariant,
    };
  }

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();

    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');

    return '$day/$month/${localDate.year}';
  }

  Future<void> _confirmReject(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('رفض الطلب'),
        content: Text(
          'هل أنت متأكد من رفض الطلب رقم #${order.id}؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('رفض الطلب'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      onReject();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final statusColor = _statusColor(colors);
    final items = order.items ?? <OrderItem>[];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                if (isUpdating)
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'تاريخ الطلب: ${_formatDate(order.createdAt)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'عنوان التوصيل',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              order.deliveryAddress,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            const Divider(),
            Text(
              'المنتجات المطلوبة',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) {
                final productName = item.product?.name ?? 'منتج غير معروف';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${item.quantity} × '
                        '${item.price.toStringAsFixed(2)} ر.س',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'إجمالي الطلب',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
            if (order.status == 'pending') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: isUpdating ? null : onAccept,
                      child: const Text('قبول الطلب'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isUpdating
                          ? null
                          : () => _confirmReject(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.error,
                      ),
                      child: const Text('رفض الطلب'),
                    ),
                  ),
                ],
              ),
            ],
            if (order.status == 'preparing') ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isUpdating ? null : onMarkReady,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('الطلب جاهز للتوصيل'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
