import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AuthRepository {
  /// تسجيل الدخول بحساب جوجل وإرجاع ملف تعريف المستخدم (UserProfileModel)
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final googleController = GoogleAuthController(
        client: client,
      );

      // تنفيذ عملية تسجيل الدخول
      await googleController.signIn();

      // التحقق مما إذا تم تسجيل الدخول بنجاح
      if (googleController.isAuthenticated || client.auth.isAuthenticated) {
        // // جلب أو إنشاء سجل المستخدم المخصص عبر السيرفر
        final appUser = await client.appAuth
            .syncGoogleUser(); // // أو الـ Endpoint الذي وضعت فيه الدالة

        return Right(appUser); // // إرجاع كائن User الموحد بنجاح
      }

      return Left(
        AuthFailure(
          googleController.errorMessage ?? 'فشل تسجيل الدخول أو تم إلغاؤه',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('حدث خطأ في الاتصال: ${e.toString()}'));
    }
  }

  // // 1. إرسال رمز الـ OTP عبر الـ Endpoint المخصص في السيرفر
  Future<Either<Failure, bool>> sendOtp({required String phone}) async {
    try {
      // // استدعاء نقطة الاتصال الخاصة بإرسال الكود
      bool isSent = await client.appAuth.sendOtp(phone);

      if (isSent) {
        return const Right(true);
      } else {
        return Left(AuthFailure('فشل إرسال رمز التحقق، تأكد من صحة الرقم'));
      }
    } catch (e) {
      return Left(ServerFailure('حدث خطأ في الاتصال: ${e.toString()}'));
    }
  }

  Future<Either<Failure, User>> verifyOtp({
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
      final errorMessage = e.toString().toLowerCase();

      if (errorMessage.contains('invalid_phone_otp')) {
        return Left(
          AuthFailure('رمز التحقق غير صحيح أو انتهت صلاحيته'),
        );
      }

      if (errorMessage.contains('invalid_phone_format')) {
        return Left(
          AuthFailure('صيغة رقم الهاتف غير صحيحة'),
        );
      }

      return Left(
        ServerFailure('تعذر إتمام تسجيل الدخول: ${e.toString()}'),
      );
    }
  }
}
