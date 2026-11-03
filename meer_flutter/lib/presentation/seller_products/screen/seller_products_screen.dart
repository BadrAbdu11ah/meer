import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/seller_products/bloc/seller_products_bloc.dart';
import 'package:meer_flutter/presentation/seller_products/view/seller_products_view.dart';

class SellerProductsScreen extends StatelessWidget {
  const SellerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إدارة منتجاتي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'تحديث المنتجات',
            onPressed: () {
              context.read<SellerProductsBloc>().add(
                const SellerProductsEvent.refreshRequested(),
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final added = await Navigator.of(context).pushNamed<bool>(
            AppRoute.productFormScreen,
          );

          if (!context.mounted) return;

          if (added == true) {
            context.read<SellerProductsBloc>().add(
              const SellerProductsEvent.refreshRequested(),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('إضافة منتج'),
      ),
      body: BlocConsumer<SellerProductsBloc, SellerProductsState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (products, updatingProductIds, message) {
              if (message == null) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: colors.error,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (products, updatingProductIds, message) {
              return SellerProductsView(
                products: products,
                updatingProductIds: updatingProductIds,
                onAvailabilityChanged: (productId, isAvailable) {
                  context.read<SellerProductsBloc>().add(
                    SellerProductsEvent.availabilityChanged(
                      productId: productId,
                      isAvailable: isAvailable,
                    ),
                  );
                },
                onDeleteRequested: (productId) {
                  context.read<SellerProductsBloc>().add(
                    SellerProductsEvent.deleteRequested(
                      productId: productId,
                    ),
                  );
                },

                onEdit: (product) async {
                  final updated = await Navigator.of(context).pushNamed<bool>(
                    AppRoute.productFormScreen,
                    arguments: product,
                  );

                  if (!context.mounted) return;

                  if (updated == true) {
                    context.read<SellerProductsBloc>().add(
                      const SellerProductsEvent.refreshRequested(),
                    );
                  }
                },
              );
            },
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () {
                        context.read<SellerProductsBloc>().add(
                          const SellerProductsEvent.started(),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
