part of 'seller_orders_bloc.dart';

@freezed
sealed class SellerOrdersEvent with _$SellerOrdersEvent {
  const factory SellerOrdersEvent.loadRequested() = SellerOrdersLoadRequested;

  const factory SellerOrdersEvent.refreshRequested() =
      SellerOrdersRefreshRequested;

  const factory SellerOrdersEvent.acceptRequested({
    required int orderId,
  }) = SellerOrderAcceptRequested;

  const factory SellerOrdersEvent.rejectRequested({
    required int orderId,
  }) = SellerOrderRejectRequested;

  const factory SellerOrdersEvent.markReadyRequested({
    required int orderId,
  }) = SellerOrderMarkReadyRequested;

  const factory SellerOrdersEvent.messageCleared() = SellerOrdersMessageCleared;
}
