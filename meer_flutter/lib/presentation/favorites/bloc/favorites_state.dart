part of 'favorites_bloc.dart';

@freezed
sealed class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(<Product>[]) List<Product> products,
    @Default(false) bool isLoading,
    String? message,
  }) = _FavoritesState;
}

extension FavoritesStateX on FavoritesState {
  bool containsProduct(int? productId) {
    if (productId == null) return false;

    return products.any(
      (product) => product.id == productId,
    );
  }

  bool get isEmpty => products.isEmpty;

  int get count => products.length;
}
