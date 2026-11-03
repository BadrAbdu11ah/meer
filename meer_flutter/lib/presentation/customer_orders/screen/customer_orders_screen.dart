import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/presentation/customer_orders/bloc/customer_orders_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/view/customer_orders_view.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  Future<void> _testGetMySellerOrders() async {
    try {
      final orders = await client.order.getMySellerOrders();

      for (final order in orders) {
        debugPrint('Order ID: ${order.id}');
        debugPrint('Status: ${order.status}');
        debugPrint('Total: ${order.totalAmount}');

        for (final item in order.items ?? <OrderItem>[]) {
          debugPrint(
            'Product: ${item.product?.name}, '
            'Quantity: ${item.quantity}',
          );
        }
      }
      // final success = await client.order.rejectMyOrder(1);
      // debugPrint('Accepted: $success');
    } catch (error, stackTrace) {
      debugPrint('Seller orders error: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

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
          IconButton(
            tooltip: 'اختبار إنشاء الطلب',
            icon: const Icon(Icons.science_outlined),
            onPressed: () => _testGetMySellerOrders(),
          ),
        ],
      ),
      body: BlocBuilder<CustomerOrdersBloc, CustomerOrdersState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (orders) => CustomerOrdersView(
              orders: orders,
            ),
            error: (message) => Center(
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
