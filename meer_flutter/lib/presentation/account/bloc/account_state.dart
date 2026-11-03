part of 'account_bloc.dart';

@freezed
sealed class AccountState with _$AccountState {
  const factory AccountState.initial() = AccountInitial;

  const factory AccountState.loading() = AccountLoading;

  const factory AccountState.loaded({
    required MeerUserProfile profile,
  }) = AccountLoaded;

  const factory AccountState.error(String message) = AccountError;
}
