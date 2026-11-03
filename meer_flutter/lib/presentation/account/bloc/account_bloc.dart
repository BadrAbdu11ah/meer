import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

part 'account_event.dart';
part 'account_state.dart';
part 'account_bloc.freezed.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._sellerRepository) : super(const AccountState.initial()) {
    on<AccountLoadRequested>(_onLoadRequested);
    on<AccountRefreshRequested>(_onRefreshRequested);
  }

  final SellerRepository _sellerRepository;

  Future<void> _onLoadRequested(
    AccountLoadRequested event,
    Emitter<AccountState> emit,
  ) async {
    await _loadProfile(emit);
  }

  Future<void> _onRefreshRequested(
    AccountRefreshRequested event,
    Emitter<AccountState> emit,
  ) async {
    await _loadProfile(emit);
  }

  Future<void> _loadProfile(
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountState.loading());

    final result = await _sellerRepository.getMyProfile();

    result.fold(
      (failure) {
        emit(AccountState.error(failure.message));
      },
      (profile) {
        emit(AccountState.loaded(profile: profile));
      },
    );
  }
}
