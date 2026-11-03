part of 'seller_details_bloc.dart';

@freezed
sealed class SellerDetailsState with _$SellerDetailsState {
  const factory SellerDetailsState.initial() = SellerDetailsInitial;

  const factory SellerDetailsState.loading() = SellerDetailsLoading;

  const factory SellerDetailsState.loaded({
    required SellerPublicInfo seller,
    required List<Product> products,
  }) = SellerDetailsLoaded;

  const factory SellerDetailsState.error(String message) = SellerDetailsError;
}
