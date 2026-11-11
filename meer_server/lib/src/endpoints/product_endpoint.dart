import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// إدارة منتجات الأسر المنتجة في تطبيق مِيْر.
class ProductEndpoint extends Endpoint {
  /// جميع دوال هذا الـ Endpoint تتطلب تسجيل الدخول.
  @override
  bool get requireLogin => true;

  /// جلب ملف البائع المرتبط بالمستخدم الحالي.
  ///
  /// لا نعتمد على sellerId يرسله تطبيق Flutter،
  /// بل نستخرج هوية المستخدم من جلسة المصادقة.
  Future<MeerUserProfile> _getCurrentSellerProfile(
    Session session,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولاً.');
    }

    final profile = await MeerUserProfile.db.findFirstRow(
      session,
      where: (p) => p.authUserId.equals(authUserId),
    );

    if (profile == null || profile.id == null) {
      throw Exception(
        'لم يتم العثور على ملف المستخدم. أكمل بيانات حسابك أولاً.',
      );
    }

    if (!profile.isSeller) {
      throw Exception(
        'يجب تفعيل صلاحية البيع قبل إدارة المنتجات.',
      );
    }

    return profile;
  }

  // --------------------------------------------------
  // 1. إضافة منتج جديد
  // --------------------------------------------------

  Future<Product> addProduct(
    Session session,
    Product product,
  ) async {
    final sellerProfile = await _getCurrentSellerProfile(session);

    final productName = product.name.trim();

    if (productName.isEmpty) {
      throw FormatException(
        'اسم المنتج لا يمكن أن يكون فارغاً.',
      );
    }

    if (!product.price.isFinite || product.price <= 0) {
      throw FormatException(
        'سعر المنتج يجب أن يكون أكبر من صفر.',
      );
    }

    // الخادم هو المسؤول عن تحديد هوية صاحب المنتج.
    product.id = null;
    product.sellerId = sellerProfile.id!;
    product.name = productName;
    product.createdAt = DateTime.now().toUtc();

    return await Product.db.insertRow(
      session,
      product,
    );
  }

  // --------------------------------------------------
  // 2. جلب المنتجات المتاحة للمشترين في مدينة محددة
  // --------------------------------------------------

  /// معرّفات الأسر المنتجة المفعّلة في المدينة.
  Future<Set<int>> _sellerIdsInCity(
    Session session,
    MeerCity city,
  ) async {
    final sellers = await MeerUserProfile.db.find(
      session,
      where: (u) => u.isSeller.equals(true) & u.storeCity.equals(city),
    );

    return {
      for (final seller in sellers)
        if (seller.id != null) seller.id!,
    };
  }

  Future<List<Product>> getAllAvailableProducts(
    Session session,
    MeerCity city,
  ) async {
    final sellerIds = await _sellerIdsInCity(session, city);

    if (sellerIds.isEmpty) {
      return [];
    }

    return await Product.db.find(
      session,
      where: (p) => p.isAvailable.equals(true) & p.sellerId.inSet(sellerIds),
    );
  }

  // --------------------------------------------------
  // 3. جلب المنتجات المتاحة لأسرة معينة
  // --------------------------------------------------

  Future<List<Product>> getProductsBySeller(
    Session session,
    int sellerId,
  ) async {
    return await Product.db.find(
      session,
      where: (p) => p.sellerId.equals(sellerId) & p.isAvailable.equals(true),
    );
  }

  // --------------------------------------------------
  // 4. جلب جميع منتجات البائع الحالي
  //    بما فيها المنتجات غير المتاحة
  // --------------------------------------------------

  Future<List<Product>> getMyProducts(
    Session session,
  ) async {
    final sellerProfile = await _getCurrentSellerProfile(session);

    return await Product.db.find(
      session,
      where: (p) => p.sellerId.equals(sellerProfile.id!),
    );
  }

  // --------------------------------------------------
  // 5. تغيير حالة توفر منتج
  //    لا يستطيع البائع تعديل منتج بائع آخر
  // --------------------------------------------------

  Future<bool> toggleProductAvailability(
    Session session,
    int productId,
    bool isAvailable,
  ) async {
    final sellerProfile = await _getCurrentSellerProfile(session);

    final product = await Product.db.findById(
      session,
      productId,
    );

    if (product == null) {
      return false;
    }

    if (product.sellerId != sellerProfile.id) {
      throw Exception(
        'لا يمكنك تعديل منتج لا تملكه.',
      );
    }

    product.isAvailable = isAvailable;

    await Product.db.updateRow(
      session,
      product,
    );

    return true;
  }

  // --------------------------------------------------
  // 6. البحث في أسماء المنتجات وأوصافها.
  // --------------------------------------------------

  /// البحث في أسماء المنتجات وأوصافها.
  Future<List<Product>> searchProducts(
    Session session,
    String search,
    MeerCity city,
  ) async {
    final query = search.trim();

    if (query.isEmpty) {
      return [];
    }

    final sellerIds = await _sellerIdsInCity(session, city);

    if (sellerIds.isEmpty) {
      return [];
    }

    final pattern = '%$query%';

    return Product.db.find(
      session,
      where: (p) =>
          p.isAvailable.equals(true) &
          p.sellerId.inSet(sellerIds) &
          (p.name.ilike(pattern) | p.description.ilike(pattern)),
    );
  }

  // --------------------------------------------------
  /// 7. تعديل منتج
  // --------------------------------------------------
  Future<Product> updateProduct(
    Session session,
    Product input,
  ) async {
    final sellerProfile = await _getCurrentSellerProfile(session);

    final productId = input.id;

    if (productId == null) {
      throw FormatException('معرّف المنتج غير صالح.');
    }

    final name = input.name.trim();
    final price = input.price;

    if (name.isEmpty) {
      throw FormatException('اسم المنتج لا يمكن أن يكون فارغًا.');
    }

    if (!price.isFinite || price <= 0) {
      throw FormatException('يجب أن يكون السعر أكبر من صفر.');
    }

    final product = await Product.db.findById(
      session,
      productId,
    );

    if (product == null) {
      throw Exception('المنتج غير موجود.');
    }

    if (product.sellerId != sellerProfile.id) {
      throw Exception('لا يمكنك تعديل منتج لا تملكه.');
    }

    final description = input.description?.trim();
    final imageUrl = input.imageUrl?.trim();

    product.name = name;
    product.description = description == null || description.isEmpty
        ? null
        : description;
    product.price = price;
    product.imageUrl = imageUrl == null || imageUrl.isEmpty ? null : imageUrl;

    // نحافظ على sellerId وcreatedAt وisAvailable الحالية.
    return await Product.db.updateRow(session, product);
  }

  // --------------------------------------------------
  /// 8. حذف منتج
  // --------------------------------------------------
  Future<bool> deleteProduct(
    Session session,
    int productId,
  ) async {
    final sellerProfile = await _getCurrentSellerProfile(session);

    final product = await Product.db.findById(
      session,
      productId,
    );

    if (product == null) {
      return false;
    }

    if (product.sellerId != sellerProfile.id) {
      throw Exception('لا يمكنك حذف منتج لا تملكه.');
    }

    final existingOrderItem = await OrderItem.db.findFirstRow(
      session,
      where: (item) => item.productId.equals(productId),
    );

    if (existingOrderItem != null) {
      throw Exception(
        'لا يمكن حذف منتج مرتبط بطلب سابق. يمكنك إيقاف عرضه بدلًا من ذلك.',
      );
    }

    await Product.db.deleteRow(session, product);

    return true;
  }
}
