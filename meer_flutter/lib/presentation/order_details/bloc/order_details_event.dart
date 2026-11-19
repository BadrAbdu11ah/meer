part of 'order_details_bloc.dart';

@freezed
sealed class OrderDetailsEvent with _$OrderDetailsEvent {
  const factory OrderDetailsEvent.loadRequested({
    required int orderId,
    required bool isSellerView,
  }) = OrderDetailsLoadRequested;

  const factory OrderDetailsEvent.refreshRequested() =
      OrderDetailsRefreshRequested;

  const factory OrderDetailsEvent.cancelRequested() =
      OrderDetailsCancelRequested;

  const factory OrderDetailsEvent.acceptRequested() =
      OrderDetailsAcceptRequested;

  const factory OrderDetailsEvent.rejectRequested() =
      OrderDetailsRejectRequested;

  const factory OrderDetailsEvent.markReadyRequested() =
      OrderDetailsMarkReadyRequested;

  const factory OrderDetailsEvent.markCompletedRequested() =
      OrderDetailsMarkCompletedRequested;

  const factory OrderDetailsEvent.messageCleared() = OrderDetailsMessageCleared;
}
