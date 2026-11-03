import 'package:hive_ce/hive_ce.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';

class CartLocalRepository {
  CartLocalRepository(this._box);

  final Box<dynamic> _box;

  static const String _cartKey = 'items';

  /// استعادة عناصر السلة من Hive.
  Future<List<CartItem>> loadItems() async {
    final storedItems = _box.get(_cartKey);

    if (storedItems is! List) {
      return [];
    }

    final restoredItems = <CartItem>[];

    for (final rawItem in storedItems) {
      if (rawItem is! Map) continue;

      try {
        final data = Map<String, dynamic>.from(rawItem);

        final productId = data['id'];
        final sellerId = data['sellerId'];
        final quantity = data['quantity'];
        final price = data['price'];
        final createdAt = data['createdAt'];

        if (productId is! int ||
            sellerId is! int ||
            quantity is! int ||
            quantity <= 0 ||
            price is! num ||
            createdAt is! String) {
          continue;
        }

        final product = Product(
          id: productId,
          sellerId: sellerId,
          name: data['name'] as String,
          description: data['description'] as String?,
          price: price.toDouble(),
          imageUrl: data['imageUrl'] as String?,
          isAvailable: data['isAvailable'] as bool? ?? false,
          createdAt: DateTime.parse(createdAt),
        );

        restoredItems.add(
          CartItem(
            product: product,
            quantity: quantity,
          ),
        );
      } catch (_) {
        // تجاهل العنصر المحلي التالف دون منع استعادة بقية السلة.
        continue;
      }
    }

    return restoredItems;
  }

  /// حفظ عناصر السلة.
  Future<void> saveItems(List<CartItem> items) async {
    final data = items.map((item) {
      final product = item.product;

      return <String, dynamic>{
        'id': product.id,
        'sellerId': product.sellerId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isAvailable': product.isAvailable,
        'createdAt': product.createdAt.toIso8601String(),
        'quantity': item.quantity,
      };
    }).toList();

    await _box.put(_cartKey, data);
    await _box.flush();
  }

  /// حذف جميع العناصر المحفوظة.
  Future<void> clear() async {
    await _box.delete(_cartKey);
    await _box.flush();
  }
}
