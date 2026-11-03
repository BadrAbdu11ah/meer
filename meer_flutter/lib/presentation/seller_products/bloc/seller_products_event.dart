part of 'seller_products_bloc.dart';

@freezed
sealed class SellerProductsEvent with _$SellerProductsEvent {
  const factory SellerProductsEvent.started() = SellerProductsStarted;

  const factory SellerProductsEvent.refreshRequested() =
      SellerProductsRefreshRequested;

  const factory SellerProductsEvent.availabilityChanged({
    required int productId,
    required bool isAvailable,
  }) = SellerProductAvailabilityChanged;
  const factory SellerProductsEvent.deleteRequested({
    required int productId,
  }) = SellerProductDeleteRequested;
}
