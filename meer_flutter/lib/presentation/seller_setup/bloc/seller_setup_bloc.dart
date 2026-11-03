import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

part 'seller_setup_event.dart';
part 'seller_setup_state.dart';
part 'seller_setup_bloc.freezed.dart';

class SellerSetupBloc extends Bloc<SellerSetupEvent, SellerSetupState> {
  final SellerRepository _sellerRepository;

  SellerSetupBloc(this._sellerRepository)
    : super(const SellerSetupState.initial()) {
    on<_SellerSetupSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    _SellerSetupSubmitted event,
    Emitter<SellerSetupState> emit,
  ) async {
    emit(const SellerSetupState.submitting());

    try {
      final result = await _sellerRepository.activateSeller(
        storeName: event.storeName,
        storeDescription: event.storeDescription,
        storeAddress: event.storeAddress,
        latitude: event.latitude,
        longitude: event.longitude,
      );

      result.fold(
        (failure) {
          emit(SellerSetupState.failure(failure.message));
        },
        (profile) {
          emit(SellerSetupState.success(profile: profile));
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        const SellerSetupState.failure(
          'حدث خطأ غير متوقع أثناء إعداد المتجر.',
        ),
      );
    }
  }
}
