import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class CustomerOrdersView extends StatelessWidget {
  const CustomerOrdersView({
    super.key,
    required this.orders,
  });

  final List<OrderInfo> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
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
                'لا توجد طلبات حتى الآن.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ستظهر طلباتك هنا بعد إتمام عملية الشراء.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _CustomerOrderCard(order: orders[index]);
      },
    );
  }
}

class _CustomerOrderCard extends StatelessWidget {
  const _CustomerOrderCard({
    required this.order,
  });

  final OrderInfo order;

  String _statusLabel(String status) {
    return switch (status) {
      'pending' => 'بانتظار قبول الأسرة',
      'preparing' => 'قيد التجهيز',
      'ready' => 'جاهز للتوصيل',
      'delivering' => 'جارٍ التوصيل',
      'completed' => 'مكتمل',
      'cancelled' => 'ملغي',
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

    return '$day/$month/${localDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final statusColor = _statusColor(order.status, colors);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const SizedBox(height: 8),
            Text(
              _formatDate(order.createdAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('إجمالي الطلب'),
                Text(
                  '${order.totalAmount.toStringAsFixed(2)} ر.س',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
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
          ],
        ),
      ),
    );
  }
}
