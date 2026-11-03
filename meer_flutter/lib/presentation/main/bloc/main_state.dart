part of 'main_bloc.dart';

@freezed
abstract class MainState with _$MainState {
  const factory MainState({
    required int currentPage,
    required Set<int> visitedPages,
  }) = _MainState;
}
