import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/core/id/injection.dart';
import 'package:meer_flutter/core/services/notification_registration_service.dart';
import 'package:meer_flutter/presentation/account/bloc/account_bloc.dart';
import 'package:meer_flutter/presentation/account/view/account_view.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<void> sendTestNotification() async {
    try {
      final sentCount = await client.notification
          .sendTestNotificationToMyDevices();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              sentCount > 0
                  ? 'تم إرسال الإشعار إلى $sentCount جهاز.'
                  : 'لا توجد أجهزة مسجلة لحسابك.',
            ),
          ),
        );
    } catch (error, stackTrace) {
      debugPrint('Test notification failed: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('فشل إرسال الإشعار التجريبي. راجع سجل الخادم.'),
          ),
        );
    }
  }

  Future<void> signOut() async {
    final notificationRegistration = sl<NotificationRegistrationService>();

    // أولًا: حذف ربط الجهاز بحساب المستخدم.
    try {
      await notificationRegistration.unregisterCurrentInstallation();
    } catch (error) {
      notificationRegistration.resumeAfterSignOutFailure();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تعذر إلغاء ربط الإشعارات. تحقق من الاتصال وحاول مجددًا.',
          ),
        ),
      );
      return;
    }

    // ثانيًا: تسجيل الخروج من Serverpod.
    try {
      await client.auth.signOutDevice();
    } catch (error) {
      notificationRegistration.resumeAfterSignOutFailure();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر تسجيل الخروج. حاول مرة أخرى.'),
        ),
      );
      return;
    }

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.loginScreen,
      (route) => false,
    );
  }

  Future<void> enableNotifications() async {
    try {
      final enabled = await sl<NotificationRegistrationService>()
          .enableNotifications();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              enabled
                  ? 'تم تفعيل الإشعارات وربط هذا الجهاز بحسابك.'
                  : 'لم يتم منح إذن الإشعارات.',
            ),
          ),
        );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('تعذر تفعيل الإشعارات. حاول مرة أخرى.'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildLoadingScreen(),

          loading: () => _buildLoadingScreen(),

          loaded: (profile) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'حسابي',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    tooltip: 'تحديث الحساب',
                    onPressed: () {
                      context.read<AccountBloc>().add(
                        const AccountEvent.refreshRequested(),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              body: AccountView(
                isSeller: profile.isSeller,
                profile: profile,

                onManageProducts: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.sellerProductsScreen,
                  );
                },

                onManageOrders: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.sellerOrdersScreen,
                  );
                },

                onEditStore: () async {
                  await Navigator.pushNamed(
                    context,
                    AppRoute.sellerSetupScreen,
                    arguments: profile,
                  );

                  if (!context.mounted) return;

                  context.read<AccountBloc>().add(
                    const AccountEvent.refreshRequested(),
                  );
                },

                onSignOut: signOut,
                onEnableNotifications: enableNotifications,

                onSendTestNotification: sendTestNotification,

                onStartSelling: () async {
                  await Navigator.pushNamed(
                    context,
                    AppRoute.sellerSetupScreen,
                  );

                  if (!context.mounted) return;

                  context.read<AccountBloc>().add(
                    const AccountEvent.refreshRequested(),
                  );
                },
              ),
            );
          },

          error: (message) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('حسابي'),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          context.read<AccountBloc>().add(
                            const AccountEvent.loadRequested(),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
