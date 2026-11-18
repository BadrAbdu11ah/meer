import 'package:meer_server/src/generated/protocol.dart';

/// أخطاء المصادقة التي تصل إلى التطبيق برمز ثابت ورسالة مفهومة.
class AuthErrors {
  static MeerException rateLimited() => MeerException(
    code: 'OTP_RATE_LIMITED',
    message: 'محاولات كثيرة. يرجى الانتظار قليلًا ثم المحاولة مرة أخرى.',
  );

  static MeerException invalidOtp() => MeerException(
    code: 'INVALID_PHONE_OTP',
    message: 'رمز التحقق غير صحيح أو انتهت صلاحيته.',
  );

  static MeerException invalidPhoneFormat() => MeerException(
    code: 'INVALID_PHONE_FORMAT',
    message: 'صيغة رقم الهاتف غير صحيحة.',
  );

  static MeerException phoneAlreadyInUse() => MeerException(
    code: 'PHONE_ALREADY_IN_USE',
    message: 'رقم الهاتف مرتبط بحساب آخر.',
  );

  static MeerException accountAlreadyHasPhone() => MeerException(
    code: 'ACCOUNT_ALREADY_HAS_PHONE',
    message: 'هذا الحساب مرتبط برقم هاتف بالفعل.',
  );
}
