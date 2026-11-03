import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/cart/view/cart_view.dart';
import 'package:meer_flutter/presentation/cart/view/widgets/cart_summary.dart';

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
        appBar: AppBar(
          title: const Text(
            'سلة المشتريات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state.isEmpty) {
                  return const SizedBox.shrink();
                }

                return IconButton(
                  tooltip: 'إفراغ السلة',
                  onPressed: () => _confirmClearCart(context),
                  icon: const Icon(Icons.delete_sweep_outlined),
                );
              },
            ),
          ],
        ),
        body: const CartView(),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoute.checkoutScreen,
                          );
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                        ),
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text('إتمام الطلب'),
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
