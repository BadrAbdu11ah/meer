part of 'account_bloc.dart';

@freezed
sealed class AccountEvent with _$AccountEvent {
  const factory AccountEvent.loadRequested() = AccountLoadRequested;

  const factory AccountEvent.refreshRequested() = AccountRefreshRequested;
}
