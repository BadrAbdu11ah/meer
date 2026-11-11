part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = CheckoutInitial;

  /// جارٍ تحديد الموقع الحالي.
  const factory CheckoutState.locating() = CheckoutLocating;

  /// بيانات التوصيل المحمّلة (عنوان وموقع محفوظان أو موقع حالي).
  const factory CheckoutState.ready({
    String? address,
    double? latitude,
    double? longitude,
  }) = CheckoutReady;

  const factory CheckoutState.submitting() = CheckoutSubmitting;

  const factory CheckoutState.success(OrderInfo order) = CheckoutSuccess;

  const factory CheckoutState.failure(String message) = CheckoutFailure;
}
