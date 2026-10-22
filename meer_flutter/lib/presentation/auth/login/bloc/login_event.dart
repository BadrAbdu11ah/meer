part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  // // طلب تسجيل الدخول بجوجل
  const factory LoginEvent.googleSignInRequested() = GoogleSignInRequested;

  // // طلب إرسال رمز التحقق برقم الهاتف
  const factory LoginEvent.sendOtpRequested({required String phone}) =
      SendOtpRequested;
}
