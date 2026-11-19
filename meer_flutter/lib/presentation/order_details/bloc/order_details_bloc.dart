import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/order_repository.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';
part 'order_details_bloc.freezed.dart';

enum _OrderDetailsAction {
  cancel,
  accept,
  reject,
  markReady,
  markCompleted,
}

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc(this._orderRepository)
    : super(const OrderDetailsState.initial()) {
    on<OrderDetailsLoadRequested>(_onLoadRequested);
    on<OrderDetailsRefreshRequested>(_onRefreshRequested);

    on<OrderDetailsCancelRequested>(
      (event, emit) => _performAction(
        _OrderDetailsAction.cancel,
        emit,
      ),
    );

    on<OrderDetailsAcceptRequested>(
      (event, emit) => _performAction(
        _OrderDetailsAction.accept,
        emit,
      ),
    );

    on<OrderDetailsRejectRequested>(
      (event, emit) => _performAction(
        _OrderDetailsAction.reject,
        emit,
      ),
    );

    on<OrderDetailsMarkReadyRequested>(
      (event, emit) => _performAction(
        _OrderDetailsAction.markReady,
        emit,
      ),
    );

    on<OrderDetailsMarkCompletedRequested>(
      (event, emit) => _performAction(
        _OrderDetailsAction.markCompleted,
        emit,
      ),
    );

    on<OrderDetailsMessageCleared>(_onMessageCleared);
  }

  final OrderRepository _orderRepository;

  int? _orderId;
  bool? _isSellerView;

  Future<void> _onLoadRequested(
    OrderDetailsLoadRequested event,
    Emitter<OrderDetailsState> emit,
  ) async {
    _orderId = event.orderId;
    _isSellerView = event.isSellerView;

    await _loadOrder(
      emit,
      showLoading: true,
    );
  }

  Future<void> _onRefreshRequested(
    OrderDetailsRefreshRequested event,
    Emitter<OrderDetailsState> emit,
  ) async {
    await _loadOrder(
      emit,
      showLoading: false,
    );
  }

  Future<void> _loadOrder(
    Emitter<OrderDetailsState> emit, {
    required bool showLoading,
  }) async {
    final orderId = _orderId;
    final isSellerView = _isSellerView;

    if (orderId == null || isSellerView == null) return;

    final previousPresentation = _currentPresentation();

    if (showLoading || previousPresentation == null) {
      emit(const OrderDetailsState.loading());
    }

    final result = await _orderRepository.getMyOrderDetails(
      orderId,
      isSellerView: isSellerView,
    );

    result.fold(
      (failure) {
        if (previousPresentation == null) {
          emit(OrderDetailsState.error(failure.message));
        } else {
          emit(
            OrderDetailsState.loaded(
              presentation: previousPresentation,
              message: failure.message,
            ),
          );
        }
      },
      (presentation) {
        emit(
          OrderDetailsState.loaded(
            presentation: presentation,
          ),
        );
      },
    );
  }

  Future<void> _performAction(
    _OrderDetailsAction action,
    Emitter<OrderDetailsState> emit,
  ) async {
    final presentation = _currentPresentation();
    final orderId = _orderId;

    if (presentation == null || orderId == null) return;

    if (_isUpdating()) return;

    if (!_isActionAllowed(presentation, action)) return;

    emit(
      OrderDetailsState.loaded(
        presentation: presentation,
        isUpdating: true,
      ),
    );

    final result = switch (action) {
      _OrderDetailsAction.cancel => await _orderRepository.cancelMyOrder(
        orderId,
      ),
      _OrderDetailsAction.accept => await _orderRepository.acceptMyOrder(
        orderId,
      ),
      _OrderDetailsAction.reject => await _orderRepository.rejectMyOrder(
        orderId,
      ),
      _OrderDetailsAction.markReady => await _orderRepository.markMyOrderReady(
        orderId,
      ),
      _OrderDetailsAction.markCompleted =>
        await _orderRepository.markMyOrderCompleted(orderId),
    };

    await result.fold<Future<void>>(
      (failure) async {
        emit(
          OrderDetailsState.loaded(
            presentation: presentation,
            message: failure.message,
          ),
        );
      },
      (_) async {
        final refreshResult = await _orderRepository.getMyOrderDetails(
          orderId,
          isSellerView: presentation.isSellerView,
        );

        refreshResult.fold(
          (failure) {
            emit(
              OrderDetailsState.loaded(
                presentation: presentation,
                message:
                    'تم تنفيذ الإجراء، لكن تعذر تحديث التفاصيل: '
                    '${failure.message}',
              ),
            );
          },
          (updatedPresentation) {
            emit(
              OrderDetailsState.loaded(
                presentation: updatedPresentation,
                message: _successMessage(action),
              ),
            );
          },
        );
      },
    );
  }

  bool _isActionAllowed(
    OrderPresentation presentation,
    _OrderDetailsAction action,
  ) {
    final status = presentation.order.status;

    if (!presentation.isSellerView) {
      return action == _OrderDetailsAction.cancel && status == 'pending';
    }

    return switch (action) {
      _OrderDetailsAction.accept ||
      _OrderDetailsAction.reject => status == 'pending',
      _OrderDetailsAction.markReady => status == 'preparing',
      _OrderDetailsAction.markCompleted => status == 'ready',
      _OrderDetailsAction.cancel => false,
    };
  }

  String _successMessage(_OrderDetailsAction action) {
    return switch (action) {
      _OrderDetailsAction.cancel => 'تم إلغاء الطلب بنجاح.',
      _OrderDetailsAction.accept => 'تم قبول الطلب.',
      _OrderDetailsAction.reject => 'تم رفض الطلب.',
      _OrderDetailsAction.markReady => 'تم تأكيد جاهزية الطلب.',
      _OrderDetailsAction.markCompleted => 'تم تأكيد تسليم الطلب للمشتري.',
    };
  }

  OrderPresentation? _currentPresentation() {
    return state.maybeWhen(
      loaded: (presentation, isUpdating, message) => presentation,
      orElse: () => null,
    );
  }

  bool _isUpdating() {
    return state.maybeWhen(
      loaded: (presentation, isUpdating, message) => isUpdating,
      orElse: () => false,
    );
  }

  void _onMessageCleared(
    OrderDetailsMessageCleared event,
    Emitter<OrderDetailsState> emit,
  ) {
    state.maybeWhen(
      loaded: (presentation, isUpdating, message) {
        emit(
          OrderDetailsState.loaded(
            presentation: presentation,
            isUpdating: isUpdating,
          ),
        );
      },
      orElse: () {},
    );
  }
}
