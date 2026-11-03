part of 'home_bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeInitial;

  const factory HomeState.loading() = _HomeLoading;

  const factory HomeState.productsLoaded({
    required List<Product> products,
  }) = _HomeProductsLoaded;

  const factory HomeState.error(String message) = _HomeError;
}
