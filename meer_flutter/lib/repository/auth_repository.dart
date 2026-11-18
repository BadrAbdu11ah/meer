import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// العملية التي حدث فيها الخطأ، لاختيار الرسالة العامة المناسبة.
enum AuthAction { googleSignIn, sendOtp, verifyOtp, linkPhone }

/// يحوّل أي خطأ في عمليات المصادقة إلى رسالة عربية آمنة للمستخدم.
///
/// - أخطاء الخادم المعروفة ([MeerException]) تُترجم حسب `code` فقط.
/// - أخطاء الشبكة تظهر كمشكلة اتصال.
/// - أي شيء آخر (بما فيه رمز غير معروف) يظهر كرسالة عامة، ولا يُعرض نص
///   الاستثناء أو رسالة الخادم للمستخدم أبدًا.
@visibleForTesting
Failure mapAuthError(Object error, AuthAction action) {
  if (error is MeerException) {
    final known = switch (error.code) {
      'OTP_RATE_LIMITED' => const AuthFailure(
        'محاولات كثيرة. يرجى الانتظار قليلًا ثم المحاولة مرة أخرى.',
      ),
      'INVALID_PHONE_OTP' => const AuthFailure(
        'رمز التحقق غير صحيح أو انتهت صلاحيته.',
      ),
      'INVALID_PHONE_FORMAT' => const AuthFailure(
        'صيغة رقم الهاتف غير صحيحة.',
      ),
      'PHONE_ALREADY_IN_USE' => const AuthFailure(
        'رقم الهاتف مرتبط بحساب آخر.',
      ),
      'ACCOUNT_ALREADY_HAS_PHONE' => const AuthFailure(
        'هذا الحساب مرتبط برقم هاتف آخر، ولا يمكن تغييره من هنا.',
      ),
      _ => null,
    };

    if (known != null) return known;
  }

  if (error is ServerpodClientNetworkException) {
    return const OfflineFailure(
      'تعذر الاتصال بالخادم. تحقق من اتصالك بالإنترنت ثم حاول مرة أخرى.',
    );
  }

  return ServerFailure(switch (action) {
    AuthAction.googleSignIn => 'تعذر تسجيل الدخول. حاول مرة أخرى.',
    AuthAction.sendOtp => smsSendFailedMessage,
    AuthAction.verifyOtp => 'تعذر إتمام تسجيل الدخول. حاول مرة أخرى.',
    AuthAction.linkPhone => 'تعذر توثيق رقم الهاتف. حاول مرة أخرى.',
  });
}

/// الخادم قبِل الطلب لكن مزود الرسائل لم يؤكد الإرسال. الرقم نفسه سليم،
/// فلا نطلب من المستخدم التأكد من رقمه.
@visibleForTesting
const smsSendFailedMessage =
    'تعذر إرسال رمز التحقق حاليًا. يرجى المحاولة بعد قليل.';

class AuthRepository {
  /// تسجيل الدخول بحساب جوجل وإرجاع ملف تعريف المستخدم (UserProfileModel)
  Future<Either<Failure, MeerUserProfile>> signInWithGoogle() async {
    GoogleAuthController? googleController;

    try {
      final controller = googleController = GoogleAuthController(
        client: client,
      );

      await controller.signIn();

      if (controller.isAuthenticated || client.auth.isAuthenticated) {
        final appUser = await client.appAuth.syncGoogleUser();

        return Right(appUser);
      }

      // لا نعرض controller.errorMessage لأنه نص الاستثناء الخام.
      return const Left(
        AuthFailure('فشل تسجيل الدخول أو تم إلغاؤه'),
      );
    } catch (e) {
      return Left(mapAuthError(e, AuthAction.googleSignIn));
    } finally {
      googleController?.dispose();
    }
  }

  // // 1. إرسال رمز الـ OTP عبر الـ Endpoint المخصص في السيرفر
  Future<Either<Failure, bool>> sendOtp({required String phone}) async {
    try {
      // // استدعاء نقطة الاتصال الخاصة بإرسال الكود
      final isSent = await client.appAuth.sendOtp(phone);

      if (isSent) {
        return const Right(true);
      }

      // الرقم غير الصالح وتجاوز الحدود يصلان كـ MeerException، فالقيمة false
      // تعني فشل مزود الرسائل فقط.
      return const Left(ServerFailure(smsSendFailedMessage));
    } catch (e) {
      return Left(mapAuthError(e, AuthAction.sendOtp));
    }
  }

  Future<Either<Failure, MeerUserProfile>> linkVerifiedPhone({
    required String phone,
    required String code,
  }) async {
    try {
      final profile = await client.appAuth.linkVerifiedPhone(
        phone,
        code,
      );

      return Right(profile);
    } catch (e) {
      return Left(mapAuthError(e, AuthAction.linkPhone));
    }
  }

  Future<Either<Failure, MeerUserProfile>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      // 1. إرسال الرمز إلى Serverpod والتحقق منه عبر Authentica.
      // الخادم يعيد AuthSuccess بعد نجاح التحقق.
      final authSuccess = await client.appAuth.verifyOtp(
        phone,
        code,
      );

      // 2. حفظ جلسة Serverpod الحديثة .
      await client.auth.updateSignedInUser(authSuccess);

      // 3. التأكد من أن العميل أصبح مسجل الدخول فعلًا.
      if (!client.auth.isAuthenticated) {
        return Left(
          AuthFailure('تعذر تفعيل جلسة تسجيل الدخول'),
        );
      }

      // 4. جلب سجل المستخدم التجاري الموجود في جدول User.
      final appUser = await client.appAuth.syncCurrentUser();

      return Right(appUser);
    } catch (e) {
      return Left(mapAuthError(e, AuthAction.verifyOtp));
    }
  }
}
