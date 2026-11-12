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

    // نجلب القائمة من الخادم في الحالتين (نجح الإلغاء أو فشل)،
    // حتى لا تبقى البطاقة تعرض حالة قديمة، مثل أن تكون الأسرة
    // قبلت الطلب قبل ضغط العميل على الإلغاء.
    final refreshResult = await _orderRepository.getMyCustomerOrders();

    final latestIds = _currentCancellingIds()..remove(event.orderId);

    final cancelMessage = result.fold(
      (failure) => failure.message,
      (_) => 'تم إلغاء الطلب بنجاح.',
    );

    refreshResult.fold(
      (failure) {
        emit(
          CustomerOrdersState.loaded(
            orders: _currentOrders() ?? orders,
            cancellingOrderIds: latestIds,
            message: result.isRight()
                ? 'تم إلغاء الطلب، لكن تعذر تحديث القائمة. '
                      'يرجى تحديثها.'
                : cancelMessage,
          ),
        );
      },
      (updatedOrders) {
        emit(
          CustomerOrdersState.loaded(
            orders: updatedOrders,
            cancellingOrderIds: latestIds,
            message: cancelMessage,
          ),
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
