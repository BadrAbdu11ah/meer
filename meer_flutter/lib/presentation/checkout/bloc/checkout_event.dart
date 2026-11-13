part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutEvent with _$CheckoutEvent {
  /// عند فتح الشاشة: تحميل موقع التوصيل المحفوظ،
  /// وإن لم يوجد نحاول أخذ موقعه الحالي.
  const factory CheckoutEvent.started() = CheckoutStarted;

  /// زر «استخدم موقعي الحالي».
  const factory CheckoutEvent.locationRequested() = CheckoutLocationRequested;

  const factory CheckoutEvent.submitted({
    required List<CartItem> items,
    required String deliveryAddress,
    double? latitude,
    double? longitude,
  }) = CheckoutSubmitted;

  const factory CheckoutEvent.phoneCodeRequested({
    required String phone,
  }) = CheckoutPhoneCodeRequested;

  const factory CheckoutEvent.phoneVerificationSubmitted({
    required String phone,
    required String code,
  }) = CheckoutPhoneVerificationSubmitted;
}
