class OrderDetailsRouteArguments {
  const OrderDetailsRouteArguments({
    required this.orderId,
    required this.isSellerView,
  });

  final int orderId;
  final bool isSellerView;
}
