part of 'cart_bloc.dart';

@freezed
sealed class CartState with _$CartState {
  const factory CartState({
    @Default(<CartItem>[]) List<CartItem> items,
    @Default(false) bool isLoading,
    String? message,
  }) = _CartState;
}

extension CartStateTotals on CartState {
  int get totalItems {
    return items.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }

  double get totalAmount {
    return items.fold(
      0.0,
      (total, item) => total + (item.product.price * item.quantity),
    );
  }

  int? get sellerId {
    return items.isEmpty ? null : items.first.product.sellerId;
  }

  bool get isEmpty => items.isEmpty;
}
