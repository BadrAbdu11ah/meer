import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/services/location_service.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

part 'seller_setup_event.dart';
part 'seller_setup_state.dart';
part 'seller_setup_bloc.freezed.dart';

class SellerSetupBloc extends Bloc<SellerSetupEvent, SellerSetupState> {
  final SellerRepository _sellerRepository;
  final LocationService _locationService;

  SellerSetupBloc(this._sellerRepository, this._locationService)
    : super(const SellerSetupState.initial()) {
    on<_SellerSetupSubmitted>(_onSubmitted);
    on<_SellerSetupLocationRequested>(_onLocationRequested);
  }

  Future<void> _onLocationRequested(
    _SellerSetupLocationRequested event,
    Emitter<SellerSetupState> emit,
  ) async {
    // لا نبدأ تحديد الموقع أثناء الحفظ أو أثناء تحديد سابق.
    final isBusy = state.maybeWhen(
      submitting: () => true,
      locating: () => true,
      orElse: () => false,
    );

    if (isBusy) return;

    emit(const SellerSetupState.locating());

    final current = await _locationService.currentCoordinates();

    if (current == null) {
      emit(
        const SellerSetupState.failure(
          'تعذر تحديد موقعك. تأكد من تفعيل الموقع ومن السماح للتطبيق بالوصول إليه.',
        ),
      );
      return;
    }

    emit(
      SellerSetupState.locationFound(
        latitude: current.latitude,
        longitude: current.longitude,
      ),
    );
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
        city: event.city,
        district: event.district,
        latitude: event.latitude,
        longitude: event.longitude,
        offersDelivery: event.offersDelivery,
        deliveryFee: event.deliveryFee,
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
