part of 'search_bloc.dart';

@freezed
class SearchStatus with _$SearchStatus {
  const factory SearchStatus.initial() = _SearchInitial;
  const factory SearchStatus.loading() = _SearchLoading;
  const factory SearchStatus.loaded() = _SearchLoaded;
  const factory SearchStatus.notFound() = _SearchNotFound;
  const factory SearchStatus.failure(String errorMessage) = _SearchFailure;
}

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.initial()) SearchStatus status,
    @Default([]) List<Product> searchResults,
  }) = _SearchState;
}
