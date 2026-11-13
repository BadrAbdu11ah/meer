part of 'seller_setup_bloc.dart';

@freezed
sealed class SellerSetupEvent with _$SellerSetupEvent {
  const factory SellerSetupEvent.submitted({
    required String storeName,
    required String? storeDescription,
    required String storeAddress,
    required MeerCity city,
    required String? district,
    required double latitude,
    required double longitude,
    required bool offersDelivery,
    required double deliveryFee,
  }) = _SellerSetupSubmitted;

  /// زر «استخدم موقعي الحالي» لتعبئة إحداثيات المتجر.
  const factory SellerSetupEvent.locationRequested() =
      _SellerSetupLocationRequested;
}
