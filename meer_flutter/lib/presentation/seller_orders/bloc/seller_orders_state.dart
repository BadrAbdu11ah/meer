part of 'seller_orders_bloc.dart';

@freezed
sealed class SellerOrdersState with _$SellerOrdersState {
  const factory SellerOrdersState.initial() = SellerOrdersInitial;

  const factory SellerOrdersState.loading() = SellerOrdersLoading;

  const factory SellerOrdersState.loaded({
    required List<OrderInfo> orders,
    @Default(<int>{}) Set<int> updatingOrderIds,
    String? message,
  }) = SellerOrdersLoaded;

  const factory SellerOrdersState.error(String message) = SellerOrdersError;
}
