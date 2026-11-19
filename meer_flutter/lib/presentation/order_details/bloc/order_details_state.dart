part of 'order_details_bloc.dart';

@freezed
sealed class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState.initial() = OrderDetailsInitial;

  const factory OrderDetailsState.loading() = OrderDetailsLoading;

  const factory OrderDetailsState.loaded({
    required OrderPresentation presentation,
    @Default(false) bool isUpdating,
    String? message,
  }) = OrderDetailsLoaded;

  const factory OrderDetailsState.error(String message) = OrderDetailsError;
}
