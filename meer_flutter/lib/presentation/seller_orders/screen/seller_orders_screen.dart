import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/seller_orders/bloc/seller_orders_bloc.dart';
import 'package:meer_flutter/presentation/seller_orders/view/seller_orders_view.dart';

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshOrders() async {
      final bloc = context.read<SellerOrdersBloc>();

      final completed = bloc.stream.firstWhere(
        (state) => state.maybeWhen(
          loaded: (_, _, _) => true,
          error: (_) => true,
          orElse: () => false,
        ),
      );

      bloc.add(
        const SellerOrdersEvent.refreshRequested(),
      );

      await completed;
    }

    return BlocConsumer<SellerOrdersBloc, SellerOrdersState>(
      listenWhen: (previous, current) {
        final previousMessage = previous.maybeWhen(
          loaded: (orders, updatingIds, message) => message,
          orElse: () => null,
        );

        final currentMessage = current.maybeWhen(
          loaded: (orders, updatingIds, message) => message,
          orElse: () => null,
        );

        return currentMessage != null && currentMessage != previousMessage;
      },
      listener: (context, state) {
        final message = state.maybeWhen(
          loaded: (orders, updatingIds, message) => message,
          orElse: () => null,
        );

        if (message == null) return;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(message)),
          );

        context.read<SellerOrdersBloc>().add(
          const SellerOrdersEvent.messageCleared(),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'الطلبات الواردة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                tooltip: 'تحديث الطلبات',
                onPressed: () {
                  context.read<SellerOrdersBloc>().add(
                    const SellerOrdersEvent.refreshRequested(),
                  );
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (orders, updatingIds, message) {
              return SellerOrdersView(
                orders: orders,
                updatingOrderIds: updatingIds,
                onAccept: (id) {
                  context.read<SellerOrdersBloc>().add(
                    SellerOrdersEvent.acceptRequested(orderId: id),
                  );
                },
                onReject: (id) {
                  context.read<SellerOrdersBloc>().add(
                    SellerOrdersEvent.rejectRequested(orderId: id),
                  );
                },
                onMarkReady: (id) {
                  context.read<SellerOrdersBloc>().add(
                    SellerOrdersEvent.markReadyRequested(orderId: id),
                  );
                },
                onRefreshRequested: refreshOrders,
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
                        context.read<SellerOrdersBloc>().add(
                          const SellerOrdersEvent.loadRequested(),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
