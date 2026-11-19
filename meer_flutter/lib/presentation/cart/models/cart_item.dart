import 'package:meer_client/meer_client.dart';

class CartItem {
  const CartItem({
    required this.product,
    required this.sellerName,
    this.quantity = 1,
  });

  final Product product;
  final String sellerName;
  final int quantity;

  CartItem copyWith({
    Product? product,
    String? sellerName,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      sellerName: sellerName ?? this.sellerName,
      quantity: quantity ?? this.quantity,
    );
  }
}
