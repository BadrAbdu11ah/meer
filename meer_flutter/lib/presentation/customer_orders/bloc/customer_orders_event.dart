part of 'customer_orders_bloc.dart';

@freezed
sealed class CustomerOrdersEvent with _$CustomerOrdersEvent {
  const factory CustomerOrdersEvent.loadRequested() =
      CustomerOrdersLoadRequested;

  const factory CustomerOrdersEvent.refreshRequested() =
      CustomerOrdersRefreshRequested;

  const factory CustomerOrdersEvent.cancelRequested({
    required int orderId,
  }) = CustomerOrderCancelRequested;

  const factory CustomerOrdersEvent.messageCleared() =
      CustomerOrdersMessageCleared;
}
