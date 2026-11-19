import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_amounts_section.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_fulfillment_section.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/order_item_tile.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/order_status_tracker.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_actions.dart';
import 'package:meer_flutter/presentation/seller_orders/view/widgets/seller_order_fulfillment_section.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    super.key,
    required this.presentation,
    required this.isUpdating,
    required this.onCancel,
    required this.onAccept,
    required this.onReject,
    required this.onMarkReady,
    required this.onMarkCompleted,
  });

  final OrderPresentation presentation;
  final bool isUpdating;

  final VoidCallback onCancel;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onMarkReady;
  final VoidCallback onMarkCompleted;

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();

    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');

    return '$day/$month/${localDate.year} - $hour:$minute';
  }

  String _statusLabel(OrderInfo order) {
    final isSellerView = presentation.isSellerView;

    return switch (order.status) {
      'pending' =>
        isSellerView ? 'طلب جديد - بانتظار قبولك' : 'بانتظار قبول الأسرة',
      'preparing' => 'قيد التجهيز',
      'ready' =>
        order.fulfillmentMethod == 'pickup' ? 'جاهز للاستلام' : 'جاهز للتوصيل',
      'delivering' => 'جارٍ التوصيل',
      'completed' => 'مكتمل',
      'cancelled' => 'تم إلغاء الطلب',
      _ => 'حالة الطلب: ${order.status}',
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

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final order = presentation.order;
    final isSellerView = presentation.isSellerView;
    final items = order.items ?? const <OrderItem>[];

    final counterpartyIcon = isSellerView
        ? Icons.person_outline
        : Icons.storefront_outlined;

    final counterpartyTitle = isSellerView ? 'العميل' : 'الأسرة';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // معلومات الطلب والطرف الآخر.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'طلب رقم #${order.id ?? '-'}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatDate(order.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      counterpartyIcon,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            counterpartyTitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            presentation.counterpartyName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(
                      order.status,
                      colors,
                    ).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _statusLabel(order),
                    style: TextStyle(
                      color: _statusColor(order.status, colors),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // مسار المتابعة مخصص لعرض العميل.
        if (!isSellerView && order.status != 'cancelled') ...[
          const SizedBox(height: 12),
          _buildSection(
            context: context,
            title: 'متابعة الطلب',
            child: OrderStatusTracker(
              status: order.status,
              fulfillmentMethod: order.fulfillmentMethod,
            ),
          ),
        ],

        const SizedBox(height: 12),

        // معلومات التوصيل أو الاستلام.
        _buildSection(
          context: context,
          title: 'طريقة تنفيذ الطلب',
          child: isSellerView
              ? SellerOrderFulfillmentSection(order: order)
              : CustomerOrderFulfillmentSection(order: order),
        ),

        const SizedBox(height: 12),

        // المنتجات المطلوبة.
        _buildSection(
          context: context,
          title: 'المنتجات (${items.length})',
          child: items.isEmpty
              ? const Text('لا توجد تفاصيل للمنتجات.')
              : Column(
                  children: [
                    for (var index = 0; index < items.length; index++) ...[
                      if (index > 0) const Divider(),
                      OrderItemTile(item: items[index]),
                    ],
                  ],
                ),
        ),

        const SizedBox(height: 12),

        // المبالغ والإجمالي.
        _buildSection(
          context: context,
          title: 'ملخص المبلغ',
          child: CustomerOrderAmountsSection(order: order),
        ),

        // إجراءات البائع.
        if (isSellerView) ...[
          if (order.status == 'pending' ||
              order.status == 'preparing' ||
              order.status == 'ready') ...[
            const SizedBox(height: 12),
            SellerOrderActions(
              status: order.status,
              isUpdating: isUpdating,
              onAccept: onAccept,
              onReject: onReject,
              onMarkReady: onMarkReady,
              onMarkCompleted: onMarkCompleted,
            ),
          ],
        ]
        // إجراء إلغاء الطلب للعميل.
        else if (order.status == 'pending') ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isUpdating ? null : onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.error,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: isUpdating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.cancel_outlined),
              label: Text(
                isUpdating ? 'جارٍ إلغاء الطلب...' : 'إلغاء الطلب',
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),
      ],
    );
  }
}
