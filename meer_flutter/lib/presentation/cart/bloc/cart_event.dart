part of 'cart_bloc.dart';

@freezed
sealed class CartEvent with _$CartEvent {
  const factory CartEvent.productAdded({
    required Product product,
  }) = CartProductAdded;

  const factory CartEvent.quantityIncreased({
    required int productId,
  }) = CartQuantityIncreased;

  const factory CartEvent.quantityDecreased({
    required int productId,
  }) = CartQuantityDecreased;

  const factory CartEvent.productRemoved({
    required int productId,
  }) = CartProductRemoved;

  const factory CartEvent.cleared() = CartCleared;

  const factory CartEvent.messageCleared() = CartMessageCleared;
}
