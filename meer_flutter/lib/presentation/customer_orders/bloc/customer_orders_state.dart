part of 'customer_orders_bloc.dart';

@freezed
sealed class CustomerOrdersState with _$CustomerOrdersState {
  const factory CustomerOrdersState.initial() = CustomerOrdersInitial;

  const factory CustomerOrdersState.loading() = CustomerOrdersLoading;

  const factory CustomerOrdersState.loaded({
    required List<OrderInfo> orders,
  }) = CustomerOrdersLoaded;

  const factory CustomerOrdersState.error(String message) = CustomerOrdersError;
}
