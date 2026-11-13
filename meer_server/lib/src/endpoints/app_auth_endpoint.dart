import 'package:meer_server/src/auth/phone_otp_idp.dart';
import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/sms_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class AppAuthEndpoint extends Endpoint {
  final SmsService _smsService = SmsService();

  PhoneOtpIdp get _phoneOtpIdp =>
      AuthServices.getIdentityProvider<PhoneOtpIdp>();

  Future<bool> hasAccount(Session session) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) return false;

    return await PhoneAuthAccount.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(authUserId),
        ) !=
        null;
  }

  bool _isValidSaudiPhone(String phone) {
    return RegExp(r'^9665\d{8}$').hasMatch(phone);
  }

  @unauthenticatedClientCall
  Future<bool> sendOtp(Session session, String phone) async {
    if (phone.trim().isEmpty) return false;

    final formattedPhone = _smsService.formatPhone(phone);

    if (!_isValidSaudiPhone(formattedPhone)) {
      return false;
    }

    return _smsService.sendOtp(session, formattedPhone);
  }

  /// ربط رقم هاتف موثّق بحساب المستخدم الحالي.
  Future<MeerUserProfile> linkVerifiedPhone(
    Session session,
    String phone,
    String code,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولاً.');
    }

    final formattedPhone = _smsService.formatPhone(phone);

    if (!_isValidSaudiPhone(formattedPhone)) {
      throw FormatException('صيغة رقم الهاتف غير صحيحة.');
    }

    if (code.trim().isEmpty) {
      throw FormatException('رمز التحقق مطلوب.');
    }

    final isValid = await _smsService.verifyOtp(
      session,
      formattedPhone,
      code.trim(),
    );

    if (!isValid) {
      throw Exception('INVALID_PHONE_OTP');
    }

    return session.db.transaction(
      (transaction) async {
        final profile = await MeerUserProfile.db.findFirstRow(
          session,
          where: (user) => user.authUserId.equals(authUserId),
          transaction: transaction,
        );

        if (profile == null || profile.id == null) {
          throw Exception('لم يتم العثور على ملف المستخدم.');
        }

        // لا نسمح بتغيير رقم حساب مرتبط بالهاتف من هذا المسار.
        if (profile.phone.trim().isNotEmpty) {
          if (profile.phone == formattedPhone) {
            return profile;
          }

          throw Exception(
            'هذا الحساب مرتبط برقم هاتف بالفعل.',
          );
        }

        // التأكد من أن الرقم غير مرتبط بحساب آخر.
        final existingAccount = await PhoneAuthAccount.db.findFirstRow(
          session,
          where: (account) => account.phone.equals(formattedPhone),
          transaction: transaction,
        );

        if (existingAccount != null &&
            existingAccount.authUserId != authUserId) {
          throw Exception('PHONE_ALREADY_IN_USE');
        }

        // إنشاء ربط المصادقة إذا لم يكن موجودًا.
        if (existingAccount == null) {
          await PhoneAuthAccount.db.insertRow(
            session,
            PhoneAuthAccount(
              authUserId: authUserId,
              phone: formattedPhone,
              createdAt: DateTime.now().toUtc(),
            ),
            transaction: transaction,
          );
        }

        profile.phone = formattedPhone;

        return MeerUserProfile.db.updateRow(
          session,
          profile,
          transaction: transaction,
        );
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  @unauthenticatedClientCall
  Future<AuthSuccess> verifyOtp(
    Session session,
    String phone,
    String code,
  ) async {
    if (phone.trim().isEmpty || code.trim().isEmpty) {
      throw Exception('INVALID_PHONE_OTP');
    }

    final formattedPhone = _smsService.formatPhone(phone);

    if (!_isValidSaudiPhone(formattedPhone)) {
      throw Exception('INVALID_PHONE_FORMAT');
    }

    // التحقق من الرمز عبر Authentica.
    final isValid = await _smsService.verifyOtp(
      session,
      formattedPhone,
      code.trim(),
    );

    if (!isValid) {
      throw Exception('INVALID_PHONE_OTP');
    }

    // إصدار جلسة المصادقة الحديثة بعد التحقق الناجح.
    return _phoneOtpIdp.login(
      session,
      phone: formattedPhone,
    );
  }

  // جلب حساب مِيْر بعد نجاح المصادقة الحديثة.
  Future<MeerUserProfile> syncCurrentUser(Session session) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    final appUser = await MeerUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (appUser == null) {
      throw Exception('لم يتم العثور على ملف المستخدم في مِيْر');
    }

    return appUser;
  }

  // 3. مزامنة أو جلب بيانات المستخدم المخصص بعد نجاح تسجيل الدخول بجوجل
  Future<MeerUserProfile> syncGoogleUser(Session session) async {
    // 1. الحصول على معرف المستخدم (UuidValue) من جلسة Serverpod النشطة
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    // 2. البحث عن المستخدم في جدولنا المخصص عبر authUserId
    var appUser = await MeerUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    // 3. إذا كان أول دخول له بجوجل، نقوم بإنشاء سجل له في جدول User
    if (appUser == null) {
      // جلب معلومات الحساب من Serverpod Auth Core
      final userProfile = await session.authenticated?.userProfile(session);

      appUser = MeerUserProfile(
        authUserId: authUserId,
        fullName: userProfile?.fullName ?? 'مستخدم جوجل',
        phone: '',
        email: userProfile?.email,
        role: 'customer',
        createdAt: DateTime.now(),
      );
      appUser = await MeerUserProfile.db.insertRow(session, appUser);
    }

    return appUser;
  }
}
