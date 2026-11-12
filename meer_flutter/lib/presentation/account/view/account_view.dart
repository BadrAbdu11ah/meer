import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({
    super.key,
    required this.isSeller,
    required this.onManageProducts,
    required this.onManageOrders,
    required this.onEditStore,
    required this.onSignOut,
    required this.onStartSelling,
  });

  final bool isSeller;
  final VoidCallback onManageProducts;
  final VoidCallback onManageOrders;
  final VoidCallback onEditStore;
  final VoidCallback onSignOut;
  final VoidCallback onStartSelling;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 0,
          color: colors.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colors.primary,
                  child: Icon(
                    Icons.person_outline,
                    size: 32,
                    color: colors.onPrimary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مرحبًا بك في مِيْر',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'إدارة حسابك ونشاطك في التطبيق',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),

        Text(
          isSeller ? 'إدارة متجرك' : 'البيع في مِيْر',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        if (isSeller) ...[
          _AccountActionTile(
            icon: Icons.inventory_2_outlined,
            title: 'إدارة منتجاتي',
            subtitle: 'إضافة المنتجات وتعديلها وإدارة توفرها',
            onTap: onManageProducts,
          ),
          _AccountActionTile(
            icon: Icons.receipt_long_outlined,
            title: 'الطلبات الواردة',
            subtitle: 'عرض طلبات عملائك وقبولها وتجهيزها',
            onTap: onManageOrders,
          ),
          _AccountActionTile(
            icon: Icons.edit_location_alt_outlined,
            title: 'تعديل بيانات الأسرة',
            subtitle: 'الاسم والمدينة والحي والعنوان',
            onTap: onEditStore,
          ),
        ] else
          _AccountActionTile(
            icon: Icons.storefront_outlined,
            title: 'ابدأ البيع',
            subtitle: 'أنشئ صفحة أسرتك المنتجة وابدأ البيع',
            onTap: onStartSelling,
          ),

        const SizedBox(height: 20),

        Text(
          'الحساب',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        _AccountActionTile(
          icon: Icons.logout,
          title: 'تسجيل الخروج',
          onTap: onSignOut,
          iconColor: colors.error,
        ),
      ],
    );
  }
}

class _AccountActionTile extends StatelessWidget {
  const _AccountActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colors.outlineVariant,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: iconColor != null
              ? colors.errorContainer
              : colors.secondaryContainer,
          child: Icon(
            icon,
            color: iconColor ?? colors.onSecondaryContainer,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
