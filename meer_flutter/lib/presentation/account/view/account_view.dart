import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/account/view/widgets/account_action_tile.dart';
import 'package:meer_flutter/presentation/account/view/widgets/account_user_info.dart';

class AccountView extends StatelessWidget {
  const AccountView({
    super.key,
    required this.isSeller,
    required this.profile,
    required this.onManageProducts,
    required this.onManageOrders,
    required this.onEditStore,
    required this.onSignOut,
    required this.onEnableNotifications,
    required this.onSendTestNotification,
    required this.onStartSelling,
  });

  final bool isSeller;
  final MeerUserProfile profile;
  final VoidCallback onManageProducts;
  final VoidCallback onManageOrders;
  final VoidCallback onEditStore;
  final VoidCallback onSignOut;
  final VoidCallback onEnableNotifications;
  final VoidCallback onSendTestNotification;
  final VoidCallback onStartSelling;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AccountUserInfo(
          colors: colors,
          theme: theme,
          name: profile.fullName,
          phone: profile.phone,
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
          AccountActionTile(
            icon: Icons.inventory_2_outlined,
            title: 'إدارة منتجاتي',
            subtitle: 'إضافة المنتجات وتعديلها وإدارة توفرها',
            onTap: onManageProducts,
          ),
          AccountActionTile(
            icon: Icons.receipt_long_outlined,
            title: 'الطلبات الواردة',
            subtitle: 'عرض طلبات عملائك وقبولها وتجهيزها',
            onTap: onManageOrders,
          ),
          AccountActionTile(
            icon: Icons.edit_location_alt_outlined,
            title: 'تعديل بيانات الأسرة',
            subtitle: 'الاسم والمدينة والحي والعنوان',
            onTap: onEditStore,
          ),
        ] else
          AccountActionTile(
            icon: Icons.storefront_outlined,
            title: 'ابدأ البيع',
            subtitle: 'أنشئ صفحة أسرتك المنتجة وابدأ البيع',
            onTap: onStartSelling,
          ),
        AccountActionTile(
          icon: Icons.notifications_active_outlined,
          title: 'تفعيل الإشعارات',
          subtitle: 'استقبل تحديثات طلباتك أولًا بأول',
          onTap: onEnableNotifications,
        ),
        AccountActionTile(
          icon: Icons.notifications_active_outlined,
          title: 'اختبار الإشعارات',
          subtitle: 'إرسال إشعار تجريبي إلى أجهزتك المسجلة',
          onTap: onSendTestNotification,
        ),
        const SizedBox(height: 20),

        Text(
          'الحساب',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        AccountActionTile(
          icon: Icons.logout,
          title: 'تسجيل الخروج',
          onTap: onSignOut,
          iconColor: colors.error,
        ),
      ],
    );
  }
}
