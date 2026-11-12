import 'dart:math';

import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// رفع صور الأسر المنتجة (صور المنتجات) إلى تخزين Serverpod.
///
/// الرفع على خطوتين:
/// 1. [createProductImageUpload]: الخادم يجهّز مسارًا ووصف رفع.
/// 2. التطبيق يرفع الملف مباشرة إلى التخزين.
/// 3. [verifyProductImageUpload]: الخادم يتأكد من الرفع ويرجع رابط الصورة.
class ImageEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _storageId = 'public';
  static const _maxFileSizeBytes = 5 * 1024 * 1024;
  static const _contentTypes = <String, String>{
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
  };

  /// رقم ملف البائع الحالي، يُستخرج من جلسة المصادقة.
  Future<int> _getCurrentSellerId(Session session) async {
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
      throw Exception('يجب تفعيل صلاحية البيع قبل رفع الصور.');
    }

    return profile.id!;
  }

  /// اسم ملف فريد لا يمكن تخمينه بسهولة.
  String _uniqueName() {
    final random = Random.secure();
    final suffix = List.generate(
      8,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();

    return '${DateTime.now().toUtc().microsecondsSinceEpoch}-$suffix';
  }

  // --------------------------------------------------
  // 1. تجهيز رفع صورة منتج
  // --------------------------------------------------

  Future<ImageUploadDescription> createProductImageUpload(
    Session session,
    String fileExtension,
  ) async {
    final sellerId = await _getCurrentSellerId(session);

    final extension = fileExtension.trim().toLowerCase().replaceFirst('.', '');
    final contentType = _contentTypes[extension];

    if (contentType == null) {
      throw FormatException(
        'صيغة الصورة غير مدعومة. استخدم JPG أو PNG أو WebP.',
      );
    }

    final filePath = 'product-images/$sellerId/${_uniqueName()}.$extension';

    final uploadDescription = await session.storage.createUploadDescription(
      storageId: _storageId,
      path: filePath,
      options: UploadOptions(
        maxFileSize: _maxFileSizeBytes,
        preventOverwrite: true,
        metadata: FileMetadata(contentType: contentType),
      ),
    );

    return ImageUploadDescription(
      filePath: filePath,
      uploadDescription: uploadDescription,
    );
  }

  // --------------------------------------------------
  // 2. التحقق من الرفع وإرجاع رابط الصورة
  // --------------------------------------------------

  Future<String> verifyProductImageUpload(
    Session session,
    String filePath,
  ) async {
    final sellerId = await _getCurrentSellerId(session);

    // نسمح بالتحقق من ملفات هذا البائع فقط.
    if (!filePath.startsWith('product-images/$sellerId/') ||
        filePath.contains('..')) {
      throw Exception('مسار الصورة غير صالح.');
    }

    final verified = await session.storage.verifyUpload(
      storageId: _storageId,
      path: filePath,
    );

    if (!verified) {
      throw Exception('تعذر التحقق من رفع الصورة. حاول مرة أخرى.');
    }

    final url = await session.storage.publicDownloadUrl(
      storageId: _storageId,
      path: filePath,
    );

    return url.toString();
  }
}
