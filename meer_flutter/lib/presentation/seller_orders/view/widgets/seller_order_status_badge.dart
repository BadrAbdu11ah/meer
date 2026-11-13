import 'package:flutter/material.dart';

class SellerOrderStatusBadge extends StatelessWidget {
  const SellerOrderStatusBadge({
    super.key,
    required this.status,
    required this.isUpdating,
  });

  final String status;
  final bool isUpdating;

  String get _label {
    return switch (status) {
      'pending' => 'طلب جديد',
      'preparing' => 'قيد التجهيز',
      'ready' => 'جاهز للتسليم',
      'delivering' => 'جارٍ التوصيل',
      'completed' => 'مكتمل',
      'cancelled' => 'ملغي',
      _ => status,
    };
  }

  Color _getColor(ColorScheme colors) {
    return switch (status) {
      'pending' => colors.tertiary,
      'preparing' => colors.primary,
      'ready' => Colors.green,
      'delivering' => colors.secondary,
      'completed' => Colors.green,
      'cancelled' => colors.error,
      _ => colors.onSurfaceVariant,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdating) {
      return const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final color = _getColor(Theme.of(context).colorScheme);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
