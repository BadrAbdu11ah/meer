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
  Future<User> syncCurrentUser(Session session) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    final appUser = await User.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (appUser == null) {
      throw Exception('لم يتم العثور على ملف المستخدم في مِيْر');
    }

    return appUser;
  }

  // 3. مزامنة أو جلب بيانات المستخدم المخصص بعد نجاح تسجيل الدخول بجوجل
  Future<User> syncGoogleUser(Session session) async {
    // 1. الحصول على معرف المستخدم (UuidValue) من جلسة Serverpod النشطة
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    // 2. البحث عن المستخدم في جدولنا المخصص عبر authUserId
    var appUser = await User.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    // 3. إذا كان أول دخول له بجوجل، نقوم بإنشاء سجل له في جدول User
    if (appUser == null) {
      // جلب معلومات الحساب من Serverpod Auth Core
      final userProfile = await session.authenticated?.userProfile(session);

      appUser = User(
        authUserId: authUserId,
        fullName: userProfile?.fullName ?? 'مستخدم جوجل',
        phone: '',
        email: userProfile?.email,
        role: 'customer',
        createdAt: DateTime.now(),
      );
      appUser = await User.db.insertRow(session, appUser);
    }

    return appUser;
  }
}
