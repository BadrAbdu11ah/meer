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
    on<CustomerOrderCancelRequested>(_onCancelRequested);
    on<CustomerOrdersMessageCleared>(_onMessageCleared);
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

  Future<void> _onCancelRequested(
    CustomerOrderCancelRequested event,
    Emitter<CustomerOrdersState> emit,
  ) async {
    final orders = _currentOrders();

    if (orders == null) return;

    // لا نسمح بإلغاء طلب غير موجود أو بدأ تجهيزه.
    final orderExists = orders.any(
      (order) => order.id == event.orderId && order.status == 'pending',
    );

    if (!orderExists) return;

    final cancellingIds = _currentCancellingIds();

    // منع تكرار عملية الإلغاء للطلب نفسه.
    if (cancellingIds.contains(event.orderId)) return;

    cancellingIds.add(event.orderId);

    emit(
      CustomerOrdersState.loaded(
        orders: orders,
        cancellingOrderIds: cancellingIds,
      ),
    );

    final result = await _orderRepository.cancelMyOrder(
      event.orderId,
    );

    await result.fold<Future<void>>(
      (failure) async {
        final latestIds = _currentCancellingIds()..remove(event.orderId);

        emit(
          CustomerOrdersState.loaded(
            orders: _currentOrders() ?? orders,
            cancellingOrderIds: latestIds,
            message: failure.message,
          ),
        );
      },
      (_) async {
        final refreshResult = await _orderRepository.getMyCustomerOrders();

        refreshResult.fold(
          (failure) {
            final latestIds = _currentCancellingIds()..remove(event.orderId);

            emit(
              CustomerOrdersState.loaded(
                orders: _currentOrders() ?? orders,
                cancellingOrderIds: latestIds,
                message:
                    'تم إلغاء الطلب، لكن تعذر تحديث القائمة. '
                    'يرجى تحديثها.',
              ),
            );
          },
          (updatedOrders) {
            final latestIds = _currentCancellingIds()..remove(event.orderId);

            emit(
              CustomerOrdersState.loaded(
                orders: updatedOrders,
                cancellingOrderIds: latestIds,
                message: 'تم إلغاء الطلب بنجاح.',
              ),
            );
          },
        );
      },
    );
  }

  void _onMessageCleared(
    CustomerOrdersMessageCleared event,
    Emitter<CustomerOrdersState> emit,
  ) {
    state.maybeWhen(
      loaded: (orders, cancellingIds, message) {
        emit(
          CustomerOrdersState.loaded(
            orders: orders,
            cancellingOrderIds: cancellingIds,
          ),
        );
      },
      orElse: () {},
    );
  }

  List<OrderInfo>? _currentOrders() {
    return state.maybeWhen(
      loaded: (orders, cancellingIds, message) => orders,
      orElse: () => null,
    );
  }

  Set<int> _currentCancellingIds() {
    return state.maybeWhen(
      loaded: (orders, cancellingIds, message) => Set<int>.from(cancellingIds),
      orElse: () => <int>{},
    );
  }
}
