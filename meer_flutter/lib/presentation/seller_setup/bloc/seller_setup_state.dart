part of 'seller_setup_bloc.dart';

@freezed
sealed class SellerSetupState with _$SellerSetupState {
  const factory SellerSetupState.initial() = _SellerSetupInitial;

  const factory SellerSetupState.submitting() = _SellerSetupSubmitting;

  const factory SellerSetupState.success({
    required MeerUserProfile profile,
  }) = _SellerSetupSuccess;

  const factory SellerSetupState.failure(String message) = _SellerSetupFailure;
}
