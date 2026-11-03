part of 'seller_details_bloc.dart';

@freezed
sealed class SellerDetailsEvent with _$SellerDetailsEvent {
  const factory SellerDetailsEvent.loadRequested({
    required int sellerId,
  }) = SellerDetailsLoadRequested;
}
