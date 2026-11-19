import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ProductPresentationService {
  Future<List<ProductPresentation>> presentProducts(
    Session session,
    List<Product> products,
  ) async {
    if (products.isEmpty) {
      return [];
    }

    // جمع معرّفات الأسر الموجودة في المنتجات.
    final sellerIds = products.map((product) => product.sellerId).toSet();

    // جلب بيانات الأسر دفعة واحدة.
    final sellers = await MeerUserProfile.db.find(
      session,
      where: (profile) => profile.id.inSet(sellerIds),
    );

    final sellersById = {
      for (final seller in sellers)
        if (seller.id != null) seller.id!: seller,
    };

    // تجهيز بيانات العرض دون إرجاع ملف الأسرة الشخصي.
    return products.map((product) {
      final seller = sellersById[product.sellerId];

      final storeName = seller?.storeName?.trim() ?? '';
      final fullName = seller?.fullName.trim() ?? '';

      final sellerName = storeName.isNotEmpty
          ? storeName
          : fullName.isNotEmpty
          ? fullName
          : 'أسرة منتجة';

      return ProductPresentation(
        product: product,
        sellerName: sellerName,
      );
    }).toList();
  }
}
