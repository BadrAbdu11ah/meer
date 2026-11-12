import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/bloc/customer_orders_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/view/customer_orders_view.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'طلباتي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'تحديث الطلبات',
            onPressed: () {
              context.read<CustomerOrdersBloc>().add(
                const CustomerOrdersEvent.refreshRequested(),
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocConsumer<CustomerOrdersBloc, CustomerOrdersState>(
        listenWhen: (previous, current) {
          final previousMessage = previous.maybeWhen(
            loaded: (_, _, message) => message,
            orElse: () => null,
          );

          final currentMessage = current.maybeWhen(
            loaded: (_, _, message) => message,
            orElse: () => null,
          );

          return currentMessage != null && currentMessage != previousMessage;
        },
        listener: (context, state) {
          final message = state.maybeWhen(
            loaded: (_, _, message) => message,
            orElse: () => null,
          );

          if (message == null) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            );

          context.read<CustomerOrdersBloc>().add(
            const CustomerOrdersEvent.messageCleared(),
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (orders, cancellingIds, message) {
              return CustomerOrdersView(
                orders: orders,
                cancellingOrderIds: cancellingIds,
                onCancel: (orderId) {
                  context.read<CustomerOrdersBloc>().add(
                    CustomerOrdersEvent.cancelRequested(
                      orderId: orderId,
                    ),
                  );
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
                        context.read<CustomerOrdersBloc>().add(
                          const CustomerOrdersEvent.loadRequested(),
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
      ),
    );
  }
}
