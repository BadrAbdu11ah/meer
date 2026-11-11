import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class FavoriteEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// جلب ملف المستخدم المرتبط بجلسة المصادقة الحالية.
  Future<MeerUserProfile> _getCurrentProfile(Session session) async {
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

  /// جلب مفضلة المستخدم الحالي مع بيانات المنتجات.
  Future<List<FavoriteProduct>> getMyFavorites(
    Session session,
  ) async {
    final profile = await _getCurrentProfile(session);

    return await FavoriteProduct.db.find(
      session,
      where: (favorite) => favorite.userId.equals(profile.id!),
      orderBy: (favorite) => favorite.createdAt.desc(),
      include: FavoriteProduct.include(
        product: Product.include(),
      ),
    );
  }

  /// إضافة منتج إلى المفضلة.
  Future<bool> addFavorite(
    Session session,
    int productId,
  ) async {
    final profile = await _getCurrentProfile(session);

    final product = await Product.db.findById(
      session,
      productId,
    );

    if (product == null) {
      throw Exception('المنتج غير موجود.');
    }

    // منع إضافة المنتج نفسه أكثر من مرة.
    final existingFavorite = await FavoriteProduct.db.findFirstRow(
      session,
      where: (favorite) =>
          favorite.userId.equals(profile.id!) &
          favorite.productId.equals(productId),
    );

    if (existingFavorite != null) {
      return true;
    }

    final favorite = FavoriteProduct(
      userId: profile.id!,
      productId: productId,
      createdAt: DateTime.now().toUtc(),
    );

    // تجاهل تعارض الفهرس الفريد عند حدوث إضافة مكررة.
    await FavoriteProduct.db.insert(
      session,
      [favorite],
      ignoreConflicts: true,
    );

    return true;
  }

  /// إزالة منتج من مفضلة المستخدم الحالي.
  Future<bool> removeFavorite(
    Session session,
    int productId,
  ) async {
    final profile = await _getCurrentProfile(session);

    final favorite = await FavoriteProduct.db.findFirstRow(
      session,
      where: (item) =>
          item.userId.equals(profile.id!) & item.productId.equals(productId),
    );

    if (favorite == null) {
      return false;
    }

    await FavoriteProduct.db.deleteRow(
      session,
      favorite,
    );

    return true;
  }

  /// إفراغ مفضلة المستخدم الحالي فقط.
  Future<void> clearMyFavorites(Session session) async {
    final profile = await _getCurrentProfile(session);

    final favorites = await FavoriteProduct.db.find(
      session,
      where: (favorite) => favorite.userId.equals(profile.id!),
    );

    if (favorites.isNotEmpty) {
      await FavoriteProduct.db.delete(
        session,
        favorites,
      );
    }
  }
}
