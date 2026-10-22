part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _LoginLoading;

  // // حالة تم إرسال الرمز بنجاح (لإظهار حقل إدخال الكود في الواجهة)
  const factory LoginState.otpSent() = _OtpSent;

  // // حالة نجاح المصادقة (سواء بجوجل أو رقم الهاتف)
  const factory LoginState.authenticated(User userProfile) = _Authenticated;

  // // حالة حدوث خطأ
  const factory LoginState.error(String message) = _LoginError;
}
