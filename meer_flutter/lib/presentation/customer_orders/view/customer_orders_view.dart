import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_card.dart';
import 'package:meer_flutter/presentation/customer_orders/view/widgets/customer_order_empty.dart';

class CustomerOrdersView extends StatelessWidget {
  const CustomerOrdersView({
    super.key,
    required this.orders,
  });

  final List<OrderInfo> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return CustomerOrderEmpty();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CustomerOrderCard(order: orders[index]);
      },
    );
  }
}
