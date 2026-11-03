part of 'customer_orders_bloc.dart';

@freezed
sealed class CustomerOrdersEvent with _$CustomerOrdersEvent {
  const factory CustomerOrdersEvent.loadRequested() =
      CustomerOrdersLoadRequested;

  const factory CustomerOrdersEvent.refreshRequested() =
      CustomerOrdersRefreshRequested;
}
