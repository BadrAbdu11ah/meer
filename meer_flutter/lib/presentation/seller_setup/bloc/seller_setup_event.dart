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
  }) = _SellerSetupSubmitted;
}
