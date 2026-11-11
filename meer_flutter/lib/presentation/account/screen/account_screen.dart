import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/account/bloc/account_bloc.dart';
import 'package:meer_flutter/presentation/account/view/account_view.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<void> signOut() async {
    try {
      // أولًا: تسجيل الخروج من Serverpod.
      await client.auth.signOutDevice();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر تسجيل الخروج. حاول مرة أخرى.'),
        ),
      );
      return;
    }

    if (!mounted) return;

    // ثالثًا: الانتقال إلى تسجيل الدخول.
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.loginScreen,
      (route) => false,
    );
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

                onSignOut: signOut,

                onStartSelling: () async {
                  await Navigator.pushNamed(
                    context,
                    AppRoute.sellerSetupScreen,
                  );
                  if (!context.mounted) return;

                  // تحديث ملف المستخدم بعد العودة من إعداد المتجر.
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
