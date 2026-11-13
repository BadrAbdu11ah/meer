import 'package:flutter/material.dart';

class SellerSetupHeader extends StatelessWidget {
  final bool isEditing;

  const SellerSetupHeader({
    super.key,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        Icon(
          Icons.storefront_outlined,
          size: 58,
          color: colors.primary,
        ),
        const SizedBox(height: 12),
        Text(
          isEditing ? 'بيانات الأسرة المنتجة' : 'ابدأ البيع في مِيْر',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'أكمل بيانات أسرتك لتتمكن من عرض منتجاتك واستقبال الطلبات.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
