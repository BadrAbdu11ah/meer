import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class SellerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // 1.
  /// جلب المعلومات العامة لأسرة منتجة.
  Future<SellerPublicInfo> getPublicSellerInfo(
    Session session,
    int sellerId,
  ) async {
    final profile = await MeerUserProfile.db.findById(
      session,
      sellerId,
    );

    if (profile == null || profile.id == null || !profile.isSeller) {
      throw Exception('لم يتم العثور على الأسرة المنتجة.');
    }

    final storeName = profile.storeName?.trim();

    if (storeName == null || storeName.isEmpty) {
      throw Exception('بيانات الأسرة المنتجة غير مكتملة.');
    }

    final description = profile.storeDescription?.trim();
    final address = profile.storeAddress?.trim();

    return SellerPublicInfo(
      sellerId: profile.id!,
      storeName: storeName,
      storeDescription: description == null || description.isEmpty
          ? null
          : description,
      storeAddress: address == null || address.isEmpty ? null : address,
    );
  }

  // 2.
  /// تفعيل البيع وحفظ بيانات المتجر للمستخدم الحالي.
  Future<MeerUserProfile> activateSeller(
    Session session,
    String storeName,
    String? storeDescription,
    String storeAddress,
    MeerCity storeCity,
    String? storeDistrict,
    double latitude,
    double longitude,
  ) async {
    // استخراج هوية المستخدم من جلسة المصادقة.
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولاً.');
    }

    // جلب ملف التطبيق المرتبط بحساب المصادقة الحالي.
    final profile = await MeerUserProfile.db.findFirstRow(
      session,
      where: (user) => user.authUserId.equals(authUserId),
    );

    if (profile == null || profile.id == null) {
      throw Exception(
        'لم يتم العثور على ملف المستخدم. أكمل تسجيل حسابك أولاً.',
      );
    }

    // التحقق من البيانات المطلوبة.
    final normalizedStoreName = storeName.trim();
    final normalizedAddress = storeAddress.trim();

    if (normalizedStoreName.isEmpty) {
      throw FormatException('اسم الأسرة المنتجة مطلوب.');
    }

    if (normalizedAddress.isEmpty) {
      throw FormatException('عنوان المتجر مطلوب.');
    }

    if (!latitude.isFinite || latitude < -90 || latitude > 90) {
      throw FormatException('إحداثيات الموقع غير صحيحة.');
    }

    if (!longitude.isFinite || longitude < -180 || longitude > 180) {
      throw FormatException('إحداثيات الموقع غير صحيحة.');
    }

    // حفظ بيانات المتجر في ملف المستخدم الحالي.
    profile.storeName = normalizedStoreName;
    profile.storeDescription = storeDescription?.trim();
    profile.storeAddress = normalizedAddress;
    profile.storeCity = storeCity;

    final normalizedDistrict = storeDistrict?.trim();
    profile.storeDistrict =
        normalizedDistrict == null || normalizedDistrict.isEmpty
        ? null
        : normalizedDistrict;
    profile.storeLatitude = latitude;
    profile.storeLongitude = longitude;

    // تفعيل البيع دون تغيير هوية المستخدم أو تعطيل الشراء.
    profile.isSeller = true;

    return await MeerUserProfile.db.updateRow(
      session,
      profile,
    );
  }

  // 3.
  /// جلب ملف المستخدم الحالي.
  Future<MeerUserProfile> getMyProfile(
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
      throw Exception(
        'لم يتم العثور على ملف المستخدم.',
      );
    }

    return profile;
  }
}
