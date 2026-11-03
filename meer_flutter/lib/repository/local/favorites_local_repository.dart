import 'package:hive_ce/hive_ce.dart';
import 'package:meer_client/meer_client.dart';

class FavoritesLocalRepository {
  FavoritesLocalRepository(this._box);

  final Box<dynamic> _box;

  static const String _favoritesKey = 'products';

  /// استعادة المنتجات المفضلة.
  Future<List<Product>> loadFavorites() async {
    final storedItems = _box.get(_favoritesKey);

    if (storedItems is! List) return [];

    final products = <Product>[];

    for (final item in storedItems) {
      if (item is! Map) continue;

      try {
        final data = Map<String, dynamic>.from(item);

        final id = data['id'];
        final sellerId = data['sellerId'];
        final price = data['price'];
        final name = data['name'];
        final createdAt = data['createdAt'];

        if (id is! int ||
            sellerId is! int ||
            price is! num ||
            name is! String ||
            createdAt is! String) {
          continue;
        }

        products.add(
          Product(
            id: id,
            sellerId: sellerId,
            name: name,
            description: data['description'] as String?,
            price: price.toDouble(),
            imageUrl: data['imageUrl'] as String?,
            isAvailable: data['isAvailable'] as bool? ?? false,
            createdAt: DateTime.parse(createdAt),
          ),
        );
      } catch (_) {
        // تجاوز البيانات التالفة مع الاستمرار في استعادة بقية المنتجات.
        continue;
      }
    }

    return products;
  }

  /// حفظ المنتجات المفضلة.
  Future<void> saveFavorites(List<Product> products) async {
    final data = products.where((product) => product.id != null).map((product) {
      return <String, dynamic>{
        'id': product.id!,
        'sellerId': product.sellerId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isAvailable': product.isAvailable,
        'createdAt': product.createdAt.toIso8601String(),
      };
    }).toList();

    await _box.put(_favoritesKey, data);
    await _box.flush();
  }

  /// إفراغ المفضلة.
  Future<void> clear() async {
    await _box.delete(_favoritesKey);
    await _box.flush();
  }
}
