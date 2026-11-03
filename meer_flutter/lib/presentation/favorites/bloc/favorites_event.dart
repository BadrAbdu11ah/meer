part of 'favorites_bloc.dart';

@freezed
sealed class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.productToggled({
    required Product product,
  }) = FavoriteProductToggled;

  const factory FavoritesEvent.cleared() = FavoritesCleared;

  const factory FavoritesEvent.messageCleared() = FavoritesMessageCleared;
}
