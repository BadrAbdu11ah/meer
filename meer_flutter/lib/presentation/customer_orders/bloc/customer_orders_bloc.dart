import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/order_repository.dart';

part 'customer_orders_event.dart';
part 'customer_orders_state.dart';
part 'customer_orders_bloc.freezed.dart';

class CustomerOrdersBloc
    extends Bloc<CustomerOrdersEvent, CustomerOrdersState> {
  CustomerOrdersBloc(this._orderRepository)
    : super(const CustomerOrdersState.initial()) {
    on<CustomerOrdersLoadRequested>(_onLoadRequested);
    on<CustomerOrdersRefreshRequested>(_onRefreshRequested);
  }

  final OrderRepository _orderRepository;

  Future<void> _onLoadRequested(
    CustomerOrdersLoadRequested event,
    Emitter<CustomerOrdersState> emit,
  ) async {
    await _loadOrders(emit);
  }

  Future<void> _onRefreshRequested(
    CustomerOrdersRefreshRequested event,
    Emitter<CustomerOrdersState> emit,
  ) async {
    await _loadOrders(emit);
  }

  Future<void> _loadOrders(
    Emitter<CustomerOrdersState> emit,
  ) async {
    emit(const CustomerOrdersState.loading());

    final result = await _orderRepository.getMyCustomerOrders();

    result.fold(
      (failure) {
        emit(CustomerOrdersState.error(failure.message));
      },
      (orders) {
        emit(CustomerOrdersState.loaded(orders: orders));
      },
    );
  }
}
