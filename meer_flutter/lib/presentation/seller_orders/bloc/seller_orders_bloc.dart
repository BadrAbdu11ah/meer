import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/order_repository.dart';

part 'seller_orders_event.dart';
part 'seller_orders_state.dart';
part 'seller_orders_bloc.freezed.dart';

enum _SellerOrderAction {
  accept,
  reject,
  markReady,
}

class SellerOrdersBloc extends Bloc<SellerOrdersEvent, SellerOrdersState> {
  SellerOrdersBloc(this._orderRepository)
    : super(const SellerOrdersState.initial()) {
    on<SellerOrdersLoadRequested>(_onLoadRequested);
    on<SellerOrdersRefreshRequested>(_onRefreshRequested);
    on<SellerOrderAcceptRequested>(_onAcceptRequested);
    on<SellerOrderRejectRequested>(_onRejectRequested);
    on<SellerOrderMarkReadyRequested>(_onMarkReadyRequested);
    on<SellerOrdersMessageCleared>(_onMessageCleared);
  }

  final OrderRepository _orderRepository;

  Future<void> _onLoadRequested(
    SellerOrdersLoadRequested event,
    Emitter<SellerOrdersState> emit,
  ) async {
    await _loadOrders(emit, showLoading: true);
  }

  Future<void> _onRefreshRequested(
    SellerOrdersRefreshRequested event,
    Emitter<SellerOrdersState> emit,
  ) async {
    await _loadOrders(emit, showLoading: false);
  }

  Future<void> _loadOrders(
    Emitter<SellerOrdersState> emit, {
    required bool showLoading,
  }) async {
    final previousOrders = _currentOrders();

    if (showLoading || previousOrders == null) {
      emit(const SellerOrdersState.loading());
    }

    final result = await _orderRepository.getMySellerOrders();

    result.fold(
      (failure) {
        if (previousOrders == null) {
          emit(SellerOrdersState.error(failure.message));
          return;
        }

        emit(
          SellerOrdersState.loaded(
            orders: _currentOrders() ?? previousOrders,
            updatingOrderIds: _currentUpdatingIds(),
            message: failure.message,
          ),
        );
      },
      (orders) {
        emit(
          SellerOrdersState.loaded(
            orders: orders,
            updatingOrderIds: _currentUpdatingIds(),
          ),
        );
      },
    );
  }

  Future<void> _onAcceptRequested(
    SellerOrderAcceptRequested event,
    Emitter<SellerOrdersState> emit,
  ) async {
    await _performAction(
      event.orderId,
      _SellerOrderAction.accept,
      emit,
    );
  }

  Future<void> _onRejectRequested(
    SellerOrderRejectRequested event,
    Emitter<SellerOrdersState> emit,
  ) async {
    await _performAction(
      event.orderId,
      _SellerOrderAction.reject,
      emit,
    );
  }

  Future<void> _onMarkReadyRequested(
    SellerOrderMarkReadyRequested event,
    Emitter<SellerOrdersState> emit,
  ) async {
    await _performAction(
      event.orderId,
      _SellerOrderAction.markReady,
      emit,
    );
  }

  Future<void> _performAction(
    int orderId,
    _SellerOrderAction action,
    Emitter<SellerOrdersState> emit,
  ) async {
    final currentOrders = _currentOrders();

    if (currentOrders == null) return;

    final currentUpdatingIds = _currentUpdatingIds();

    if (currentUpdatingIds.contains(orderId)) return;

    final orderExists = currentOrders.any(
      (order) => order.id == orderId,
    );

    if (!orderExists) return;

    emit(
      SellerOrdersState.loaded(
        orders: currentOrders,
        updatingOrderIds: {
          ...currentUpdatingIds,
          orderId,
        },
      ),
    );

    final result = switch (action) {
      _SellerOrderAction.accept => await _orderRepository.acceptMyOrder(
        orderId,
      ),
      _SellerOrderAction.reject => await _orderRepository.rejectMyOrder(
        orderId,
      ),
      _SellerOrderAction.markReady => await _orderRepository.markMyOrderReady(
        orderId,
      ),
    };

    await result.fold<Future<void>>(
      (failure) async {
        final latestOrders = _currentOrders() ?? currentOrders;
        final latestUpdatingIds = _currentUpdatingIds()..remove(orderId);

        emit(
          SellerOrdersState.loaded(
            orders: latestOrders,
            updatingOrderIds: latestUpdatingIds,
            message: failure.message,
          ),
        );
      },
      (_) async {
        final refreshed = await _orderRepository.getMySellerOrders();

        refreshed.fold(
          (failure) {
            final latestOrders = _currentOrders() ?? currentOrders;
            final latestUpdatingIds = _currentUpdatingIds()..remove(orderId);

            emit(
              SellerOrdersState.loaded(
                orders: latestOrders,
                updatingOrderIds: latestUpdatingIds,
                message:
                    'تم تحديث الطلب، لكن تعذر تحديث القائمة: '
                    '${failure.message}',
              ),
            );
          },
          (orders) {
            final latestUpdatingIds = _currentUpdatingIds()..remove(orderId);

            final message = switch (action) {
              _SellerOrderAction.accept => 'تم قبول الطلب.',
              _SellerOrderAction.reject => 'تم رفض الطلب.',
              _SellerOrderAction.markReady => 'تم تأكيد جاهزية الطلب.',
            };

            emit(
              SellerOrdersState.loaded(
                orders: orders,
                updatingOrderIds: latestUpdatingIds,
                message: message,
              ),
            );
          },
        );
      },
    );
  }

  void _onMessageCleared(
    SellerOrdersMessageCleared event,
    Emitter<SellerOrdersState> emit,
  ) {
    state.maybeWhen(
      loaded: (orders, updatingOrderIds, message) {
        emit(
          SellerOrdersState.loaded(
            orders: orders,
            updatingOrderIds: updatingOrderIds,
          ),
        );
      },
      orElse: () {},
    );
  }

  List<OrderInfo>? _currentOrders() {
    return state.maybeWhen(
      loaded: (orders, updatingOrderIds, message) => orders,
      orElse: () => null,
    );
  }

  Set<int> _currentUpdatingIds() {
    return state.maybeWhen(
      loaded: (orders, updatingOrderIds, message) =>
          Set<int>.from(updatingOrderIds),
      orElse: () => <int>{},
    );
  }
}
