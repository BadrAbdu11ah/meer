part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started({
    required int sellerId,
  }) = CheckoutStarted;

  const factory CheckoutEvent.locationRequested() = CheckoutLocationRequested;

  const factory CheckoutEvent.fulfillmentMethodChanged({
    required String method,
  }) = CheckoutFulfillmentMethodChanged;

  const factory CheckoutEvent.submitted({
    required List<CartItem> items,
    String? deliveryAddress,
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

  const factory CheckoutEvent.addressChanged({
    required String address,
  }) = CheckoutAddressChanged;
}
