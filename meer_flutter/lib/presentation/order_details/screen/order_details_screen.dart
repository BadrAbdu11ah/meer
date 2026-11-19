import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/order_details/bloc/order_details_bloc.dart';
import 'package:meer_flutter/presentation/order_details/view/order_details_view.dart';
import 'package:meer_flutter/presentation/shared/widgets/app_page_header.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.isSellerView,
  });

  final int orderId;
  final bool isSellerView;

  Future<void> _confirmCancel(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إلغاء الطلب'),
        content: Text(
          'هل أنت متأكد من إلغاء الطلب رقم #$orderId؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('رجوع'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<OrderDetailsBloc>().add(
        const OrderDetailsEvent.cancelRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppPageHeader(
            title: 'تفاصيل الطلب',
            subtitle: 'متابعة حالة الطلب وإجراءاته',
            showBackButton: Navigator.of(context).canPop(),
            onBack: () => Navigator.of(context).maybePop(),
            actions: [
              IconButton(
                tooltip: 'تحديث التفاصيل',
                onPressed: () {
                  context.read<OrderDetailsBloc>().add(
                    const OrderDetailsEvent.refreshRequested(),
                  );
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<OrderDetailsBloc, OrderDetailsState>(
              listenWhen: (previous, current) {
                final previousMessage = previous.maybeWhen(
                  loaded: (_, _, message) => message,
                  orElse: () => null,
                );

                final currentMessage = current.maybeWhen(
                  loaded: (_, _, message) => message,
                  orElse: () => null,
                );

                return currentMessage != null &&
                    currentMessage != previousMessage;
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

                context.read<OrderDetailsBloc>().add(
                  const OrderDetailsEvent.messageCleared(),
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
                  loaded: (presentation, isUpdating, message) {
                    return OrderDetailsView(
                      presentation: presentation,
                      isUpdating: isUpdating,
                      onCancel: () => _confirmCancel(context),
                      onAccept: () {
                        context.read<OrderDetailsBloc>().add(
                          const OrderDetailsEvent.acceptRequested(),
                        );
                      },
                      onReject: () {
                        context.read<OrderDetailsBloc>().add(
                          const OrderDetailsEvent.rejectRequested(),
                        );
                      },
                      onMarkReady: () {
                        context.read<OrderDetailsBloc>().add(
                          const OrderDetailsEvent.markReadyRequested(),
                        );
                      },
                      onMarkCompleted: () {
                        context.read<OrderDetailsBloc>().add(
                          const OrderDetailsEvent.markCompletedRequested(),
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
                              context.read<OrderDetailsBloc>().add(
                                OrderDetailsEvent.loadRequested(
                                  orderId: orderId,
                                  isSellerView: isSellerView,
                                ),
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
          ),
        ],
      ),
    );
  }
}
