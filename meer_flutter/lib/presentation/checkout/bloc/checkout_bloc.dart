import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/services/location_service.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';
import 'package:meer_flutter/repository/order_repository.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(
    this._orderRepository,
    this._sellerRepository,
    this._locationService,
  ) : super(const CheckoutState.initial()) {
    on<CheckoutStarted>(_onStarted);
    on<CheckoutLocationRequested>(_onLocationRequested);
    on<CheckoutSubmitted>(_onSubmitted);
  }

  final OrderRepository _orderRepository;
  final SellerRepository _sellerRepository;
  final LocationService _locationService;

  /// تحميل موقع التوصيل المحفوظ في ملف المستخدم.
  /// إذا لم يكن له موقع محفوظ (أول طلب) نحاول أخذ موقعه الحالي.
  Future<void> _onStarted(
    CheckoutStarted event,
    Emitter<CheckoutState> emit,
  ) async {
    final result = await _sellerRepository.getMyProfile();

    final saved =
        result.fold<({String? address, double? latitude, double? longitude})?>(
          (_) => null,
          (profile) => (
            address: profile.address,
            latitude: profile.latitude,
            longitude: profile.longitude,
          ),
        );

    var latitude = saved?.latitude;
    var longitude = saved?.longitude;

    if (latitude == null || longitude == null) {
      final current = await _locationService.currentCoordinates();

      if (current != null) {
        latitude = current.latitude;
        longitude = current.longitude;
      }
    }

    emit(
      CheckoutState.ready(
        address: saved?.address,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  Future<void> _onLocationRequested(
    CheckoutLocationRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(const CheckoutState.locating());

    final current = await _locationService.currentCoordinates();

    if (current == null) {
      emit(
        const CheckoutState.failure(
          'تعذر تحديد موقعك. تأكد من تفعيل الموقع ومن السماح للتطبيق بالوصول إليه.',
        ),
      );
      return;
    }

    emit(
      CheckoutState.ready(
        latitude: current.latitude,
        longitude: current.longitude,
      ),
    );
  }

  Future<void> _onSubmitted(
    CheckoutSubmitted event,
    Emitter<CheckoutState> emit,
  ) async {
    if (state.maybeWhen(
      submitting: () => true,
      orElse: () => false,
    )) {
      return;
    }

    final address = event.deliveryAddress.trim();

    if (address.isEmpty) {
      emit(
        const CheckoutState.failure(
          'يرجى إدخال عنوان التوصيل.',
        ),
      );
      return;
    }

    if (event.items.isEmpty) {
      emit(
        const CheckoutState.failure(
          'السلة فارغة، أضف منتجات أولاً.',
        ),
      );
      return;
    }

    emit(const CheckoutState.submitting());

    try {
      final requestedItems = <OrderItemRequest>[];

      for (final item in event.items) {
        final productId = item.product.id;

        if (productId == null || item.quantity <= 0) {
          emit(
            const CheckoutState.failure(
              'توجد بيانات غير صحيحة لأحد منتجات السلة.',
            ),
          );
          return;
        }

        requestedItems.add(
          OrderItemRequest(
            productId: productId,
            quantity: item.quantity,
          ),
        );
      }

      final result = await _orderRepository.createOrder(
        items: requestedItems,
        deliveryAddress: address,
        deliveryLatitude: event.latitude,
        deliveryLongitude: event.longitude,
      );

      OrderInfo? createdOrder;
      String? failureMessage;

      result.fold(
        (failure) => failureMessage = failure.message,
        (order) => createdOrder = order,
      );

      final order = createdOrder;

      if (order == null) {
        emit(
          CheckoutState.failure(
            failureMessage ?? 'تعذر إنشاء الطلب. حاول مرة أخرى.',
          ),
        );
        return;
      }

      emit(CheckoutState.success(order));

      // نحفظ موقع التوصيل في ملفه ليُستخدم في الطلبات القادمة.
      // فشل الحفظ لا يؤثر على الطلب الذي تم إنشاؤه.
      final latitude = event.latitude;
      final longitude = event.longitude;

      if (latitude != null && longitude != null) {
        await _sellerRepository.updateMyDeliveryLocation(
          address: address,
          latitude: latitude,
          longitude: longitude,
        );
      }
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        const CheckoutState.failure(
          'حدث خطأ أثناء إرسال الطلب. حاول مرة أخرى.',
        ),
      );
    }
  }
}
