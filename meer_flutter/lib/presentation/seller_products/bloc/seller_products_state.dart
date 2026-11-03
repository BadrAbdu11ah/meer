part of 'seller_products_bloc.dart';

@freezed
sealed class SellerProductsState with _$SellerProductsState {
  const factory SellerProductsState.initial() = _SellerProductsInitial;

  const factory SellerProductsState.loading() = _SellerProductsLoading;

  const factory SellerProductsState.loaded({
    required List<Product> products,
    @Default(<int>{}) Set<int> updatingProductIds,
    String? message,
  }) = _SellerProductsLoaded;

  const factory SellerProductsState.error(String message) =
      _SellerProductsError;
}
