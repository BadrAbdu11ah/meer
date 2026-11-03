part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = CheckoutInitial;

  const factory CheckoutState.submitting() = CheckoutSubmitting;

  const factory CheckoutState.success(OrderInfo order) = CheckoutSuccess;

  const factory CheckoutState.failure(String message) = CheckoutFailure;
}
