part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = CheckoutInitial;

  const factory CheckoutState.locating() = CheckoutLocating;

  const factory CheckoutState.ready({
    String? address,
    double? latitude,
    double? longitude,

    // إعدادات الأسرة.
    @Default(false) bool sellerOffersDelivery,
    @Default(0) double sellerDeliveryFee,

    // طريقة التنفيذ المختارة.
    @Default('pickup') String fulfillmentMethod,

    // بيانات الهاتف.
    @Default('') String phone,
    @Default(false) bool isPhoneVerified,
    @Default(false) bool isSendingPhoneCode,
    @Default(false) bool isPhoneCodeSent,
    @Default(false) bool isVerifyingPhone,

    String? errorMessage,
  }) = CheckoutReady;

  const factory CheckoutState.submitting() = CheckoutSubmitting;

  const factory CheckoutState.success(OrderInfo order) = CheckoutSuccess;

  const factory CheckoutState.failure(String message) = CheckoutFailure;
}
