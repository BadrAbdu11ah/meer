import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class CartEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // --------------------------------------------------
  // 1. استخراج ملف المستخدم الحالي
  // --------------------------------------------------

  Future<MeerUserProfile> _getCurrentProfile(
    Session session,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولاً.');
    }

    final profile = await MeerUserProfile.db.findFirstRow(
      session,
      where: (user) => user.authUserId.equals(authUserId),
    );

    if (profile == null || profile.id == null) {
      throw Exception('لم يتم العثور على ملف المستخدم.');
    }

    return profile;
  }

  // --------------------------------------------------
  // 2. جلب سلة المستخدم الحالي
  // --------------------------------------------------

  Future<List<CartItemRecord>> getMyCart(
    Session session,
  ) async {
    final profile = await _getCurrentProfile(session);

    return await CartItemRecord.db.find(
      session,
      where: (item) => item.userId.equals(profile.id!),
      orderBy: (item) => item.createdAt.asc(),
      include: CartItemRecord.include(
        product: Product.include(),
      ),
    );
  }

  // --------------------------------------------------
  // 3. إضافة منتج أو زيادة كميته
  // --------------------------------------------------

  Future<CartItemRecord> addItem(
    Session session,
    int productId,
    int quantity,
  ) async {
    final profile = await _getCurrentProfile(session);

    if (quantity <= 0) {
      throw FormatException('الكمية يجب أن تكون أكبر من صفر.');
    }

    return await session.db.transaction(
      (transaction) async {
        final product = await Product.db.findById(
          session,
          productId,
          transaction: transaction,
        );

        if (product == null) {
          throw Exception('المنتج غير موجود.');
        }

        if (!product.isAvailable) {
          throw Exception('المنتج غير متاح للبيع حاليًا.');
        }

        // جلب عناصر السلة للتحقق من الأسرة المالكة للمنتجات.
        final cartItems = await CartItemRecord.db.find(
          session,
          where: (item) => item.userId.equals(profile.id!),
          transaction: transaction,
          include: CartItemRecord.include(
            product: Product.include(),
          ),
        );

        for (final item in cartItems) {
          final existingProduct = item.product;

          if (existingProduct == null) {
            throw Exception(
              'توجد بيانات غير مكتملة في السلة.',
            );
          }

          if (existingProduct.sellerId != product.sellerId) {
            throw Exception(
              'السلة تحتوي على منتجات أسرة أخرى. '
              'أفرغ السلة أولاً لإضافة هذا المنتج.',
            );
          }
        }

        final existingItem = cartItems.where(
          (item) => item.productId == productId,
        );

        final now = DateTime.now().toUtc();

        if (existingItem.isNotEmpty) {
          final item = existingItem.first;

          item.quantity += quantity;
          item.updatedAt = now;

          return await CartItemRecord.db.updateRow(
            session,
            item,
            transaction: transaction,
          );
        }

        return await CartItemRecord.db.insertRow(
          session,
          CartItemRecord(
            userId: profile.id!,
            productId: productId,
            quantity: quantity,
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  // --------------------------------------------------
  // 4. تعديل كمية منتج
  // --------------------------------------------------

  Future<bool> updateQuantity(
    Session session,
    int productId,
    int quantity,
  ) async {
    final profile = await _getCurrentProfile(session);

    if (quantity <= 0) {
      throw FormatException('الكمية يجب أن تكون أكبر من صفر.');
    }

    return await session.db.transaction(
      (transaction) async {
        final item = await CartItemRecord.db.findFirstRow(
          session,
          where: (row) =>
              row.userId.equals(profile.id!) & row.productId.equals(productId),
          transaction: transaction,
        );

        if (item == null) return false;

        final product = await Product.db.findById(
          session,
          productId,
          transaction: transaction,
        );

        if (product == null) {
          throw Exception('المنتج لم يعد موجودًا.');
        }

        // يمكن تقليل الكمية، لكن لا نسمح بزيادتها
        // إذا أوقف البائع توفر المنتج.
        if (!product.isAvailable && quantity > item.quantity) {
          throw Exception('المنتج غير متاح للبيع حاليًا.');
        }

        item.quantity = quantity;
        item.updatedAt = DateTime.now().toUtc();

        await CartItemRecord.db.updateRow(
          session,
          item,
          transaction: transaction,
        );

        return true;
      },
    );
  }

  // --------------------------------------------------
  // 5. حذف منتج من السلة
  // --------------------------------------------------

  Future<bool> removeItem(
    Session session,
    int productId,
  ) async {
    final profile = await _getCurrentProfile(session);

    final item = await CartItemRecord.db.findFirstRow(
      session,
      where: (row) =>
          row.userId.equals(profile.id!) & row.productId.equals(productId),
    );

    if (item == null) return false;

    await CartItemRecord.db.deleteRow(
      session,
      item,
    );

    return true;
  }

  // --------------------------------------------------
  // 6. إفراغ السلة
  // --------------------------------------------------

  Future<void> clearCart(
    Session session,
  ) async {
    final profile = await _getCurrentProfile(session);

    await session.db.transaction(
      (transaction) async {
        final items = await CartItemRecord.db.find(
          session,
          where: (item) => item.userId.equals(profile.id!),
          transaction: transaction,
        );

        for (final item in items) {
          await CartItemRecord.db.deleteRow(
            session,
            item,
            transaction: transaction,
          );
        }
      },
    );
  }
}
