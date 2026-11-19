import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/cart/view/cart_view.dart';
import 'package:meer_flutter/presentation/cart/view/widgets/cart_summary.dart';
import 'package:meer_flutter/presentation/shared/widgets/app_page_header.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _confirmClearCart(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إفراغ السلة'),
        content: const Text(
          'هل تريد حذف جميع المنتجات من السلة؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('إفراغ السلة'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CartBloc>().add(
        const CartEvent.cleared(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) =>
          previous.message != current.message && current.message != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(state.message!)),
          );

        context.read<CartBloc>().add(
          const CartEvent.messageCleared(),
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            AppPageHeader(
              title: 'سلة المشتريات',
              subtitle: 'راجع منتجاتك قبل إتمام الطلب',
              showBackButton: Navigator.of(context).canPop(),
              onBack: () {
                Navigator.of(context).maybePop();
              },
              actions: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return IconButton(
                      tooltip: 'إفراغ السلة',
                      onPressed: state.isLoading
                          ? null
                          : () => _confirmClearCart(context),
                      icon: const Icon(Icons.delete_sweep_outlined),
                    );
                  },
                ),
              ],
            ),
            Expanded(child: const CartView()),
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.isEmpty) {
              return const SizedBox.shrink();
            }

            return SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CartSummary(
                    totalItems: state.totalItems,
                    totalAmount: state.totalAmount,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                Navigator.of(context).pushNamed(
                                  AppRoute.checkoutScreen,
                                );
                              },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                        ),
                        icon: state.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.shopping_bag_outlined),
                        label: Text(
                          state.isLoading
                              ? 'جارٍ تحديث السلة...'
                              : 'إتمام الطلب',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
