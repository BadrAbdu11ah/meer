part of 'favorites_bloc.dart';

@freezed
sealed class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(<ProductPresentation>[]) List<ProductPresentation> products,
    @Default(false) bool isLoading,
    String? message,
  }) = _FavoritesState;
}

extension FavoritesStateX on FavoritesState {
  bool containsProduct(int? productId) {
    if (productId == null) return false;

    return products.any(
      (presentation) => presentation.product.id == productId,
    );
  }

  bool get isEmpty => products.isEmpty;

  int get count => products.length;
}
