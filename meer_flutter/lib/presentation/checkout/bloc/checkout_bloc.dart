import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/services/location_service.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';
import 'package:meer_flutter/repository/auth_repository.dart';
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
    this._authRepository,
  ) : super(const CheckoutState.initial()) {
    on<CheckoutStarted>(_onStarted);
    on<CheckoutLocationRequested>(_onLocationRequested);
    on<CheckoutFulfillmentMethodChanged>(
      _onFulfillmentMethodChanged,
    );
    on<CheckoutPhoneCodeRequested>(_onPhoneCodeRequested);
    on<CheckoutPhoneVerificationSubmitted>(
      _onPhoneVerificationSubmitted,
    );
    on<CheckoutAddressChanged>(_onAddressChanged);
    on<CheckoutSubmitted>(_onSubmitted);
  }

  final OrderRepository _orderRepository;
  final SellerRepository _sellerRepository;
  final LocationService _locationService;
  final AuthRepository _authRepository;

  bool _isVerifiedSaudiPhone(String phone) {
    return RegExp(r'^9665\d{8}$').hasMatch(phone.trim());
  }

  /// تحميل موقع التوصيل المحفوظ في ملف المستخدم.
  /// إذا لم يكن له موقع محفوظ (أول طلب) نحاول أخذ موقعه الحالي.
  Future<void> _onStarted(
    CheckoutStarted event,
    Emitter<CheckoutState> emit,
  ) async {
    // تحميل معلومات الأسرة أولاً.
    final sellerResult = await _sellerRepository.getPublicSellerInfo(
      sellerId: event.sellerId,
    );

    final seller = sellerResult.fold(
      (failure) => null,
      (profile) => profile,
    );

    if (seller == null) {
      final message = sellerResult.fold(
        (failure) => failure.message,
        (_) => 'تعذر تحميل معلومات الأسرة.',
      );

      emit(CheckoutState.failure(message));
      return;
    }

    // تحميل بيانات العميل المحفوظة.
    final result = await _sellerRepository.getMyProfile();

    final saved = result
        .fold<
          ({
            String? address,
            double? latitude,
            double? longitude,
            String phone,
          })?
        >(
          (_) => null,
          (profile) => (
            address: profile.address,
            latitude: profile.latitude,
            longitude: profile.longitude,
            phone: profile.phone,
          ),
        );

    // الموقع المحفوظ فقط. لا نطلب إذن الموقع عند فتح الصفحة،
    // لأن الاستلام هو الاختيار الافتراضي ولا يحتاج موقعًا.
    final latitude = saved?.latitude;
    final longitude = saved?.longitude;

    final phone = saved?.phone ?? '';

    emit(
      CheckoutState.ready(
        address: saved?.address,
        latitude: latitude,
        longitude: longitude,
        phone: phone,
        isPhoneVerified: _isVerifiedSaudiPhone(phone),
        sellerOffersDelivery: seller.offersDelivery,
        sellerDeliveryFee: seller.deliveryFee,
        fulfillmentMethod: 'pickup',
      ),
    );
  }

  Future<void> _onLocationRequested(
    CheckoutLocationRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    final previousState = state;
    emit(const CheckoutState.locating());

    final current = await _locationService.currentCoordinates();

    if (current == null) {
      const message =
          'تعذر تحديد موقعك. تأكد من تفعيل الموقع ومن السماح للتطبيق بالوصول إليه.';

      if (previousState is CheckoutReady) {
        emit(previousState.copyWith(errorMessage: message));
      } else {
        emit(const CheckoutState.failure(message));
      }
      return;
    }

    if (previousState is CheckoutReady) {
      emit(
        previousState.copyWith(
          latitude: current.latitude,
          longitude: current.longitude,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        CheckoutState.ready(
          latitude: current.latitude,
          longitude: current.longitude,
        ),
      );
    }
  }

  void _onFulfillmentMethodChanged(
    CheckoutFulfillmentMethodChanged event,
    Emitter<CheckoutState> emit,
  ) {
    final current = state;

    if (current is! CheckoutReady) return;

    if (event.method != 'delivery' && event.method != 'pickup') {
      return;
    }

    // لا تسمح باختيار التوصيل إذا كانت الأسرة لا توفره.
    if (event.method == 'delivery' && !current.sellerOffersDelivery) {
      emit(
        current.copyWith(
          errorMessage: 'هذه الأسرة لا توفر خدمة التوصيل.',
        ),
      );
      return;
    }

    emit(
      current.copyWith(
        fulfillmentMethod: event.method,
        errorMessage: null,
      ),
    );

    // التوصيل يحتاج موقع العميل: نطلبه الآن إن لم يكن محفوظًا.
    if (event.method == 'delivery' &&
        (current.latitude == null || current.longitude == null)) {
      add(const CheckoutEvent.locationRequested());
    }
  }

  Future<void> _onPhoneCodeRequested(
    CheckoutPhoneCodeRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    final current = state;

    if (current is! CheckoutReady ||
        current.isSendingPhoneCode ||
        current.isVerifyingPhone) {
      return;
    }

    emit(
      current.copyWith(
        phone: event.phone.trim(),
        isSendingPhoneCode: true,
        isPhoneCodeSent: false,
        errorMessage: null,
      ),
    );

    final result = await _authRepository.sendOtp(
      phone: event.phone.trim(),
    );

    final latest = state;
    if (latest is! CheckoutReady) return;

    result.fold(
      (failure) {
        emit(
          latest.copyWith(
            isSendingPhoneCode: false,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(
          latest.copyWith(
            isSendingPhoneCode: false,
            isPhoneCodeSent: true,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onPhoneVerificationSubmitted(
    CheckoutPhoneVerificationSubmitted event,
    Emitter<CheckoutState> emit,
  ) async {
    final current = state;

    if (current is! CheckoutReady ||
        !current.isPhoneCodeSent ||
        current.isVerifyingPhone) {
      return;
    }

    emit(
      current.copyWith(
        isVerifyingPhone: true,
        errorMessage: null,
      ),
    );

    final result = await _authRepository.linkVerifiedPhone(
      phone: event.phone.trim(),
      code: event.code.trim(),
    );

    final latest = state;
    if (latest is! CheckoutReady) return;

    result.fold(
      (failure) {
        emit(
          latest.copyWith(
            isVerifyingPhone: false,
            errorMessage: failure.message,
          ),
        );
      },
      (profile) {
        emit(
          latest.copyWith(
            phone: profile.phone,
            isPhoneVerified: _isVerifiedSaudiPhone(profile.phone),
            isPhoneCodeSent: false,
            isVerifyingPhone: false,
            errorMessage: null,
          ),
        );
      },
    );
  }

  void _onAddressChanged(
    CheckoutAddressChanged event,
    Emitter<CheckoutState> emit,
  ) {
    final current = state;

    if (current is! CheckoutReady) return;

    emit(
      current.copyWith(
        // الإحداثيات تصف مكان العميل، فلا تُمسح بتعديل نص العنوان.
        address: event.address,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmitted(
    CheckoutSubmitted event,
    Emitter<CheckoutState> emit,
  ) async {
    final readyState = state;

    if (readyState is! CheckoutReady) return;

    if (!readyState.isPhoneVerified) {
      emit(
        readyState.copyWith(
          errorMessage: 'يجب توثيق رقم هاتفك قبل تأكيد الطلب.',
        ),
      );
      return;
    }

    if (event.items.isEmpty) {
      emit(
        readyState.copyWith(
          errorMessage: 'السلة فارغة، أضف منتجات أولاً.',
        ),
      );
      return;
    }

    final fulfillmentMethod = readyState.fulfillmentMethod;

    final isDelivery = fulfillmentMethod == 'delivery';

    if (isDelivery && !readyState.sellerOffersDelivery) {
      emit(
        readyState.copyWith(
          errorMessage: 'هذه الأسرة لا توفر خدمة التوصيل.',
        ),
      );
      return;
    }

    // عنوان العميل مطلوب للتوصيل فقط.
    final address = isDelivery ? event.deliveryAddress?.trim() : null;

    if (isDelivery && (address == null || address.isEmpty)) {
      emit(
        readyState.copyWith(
          errorMessage: 'يرجى إدخال عنوان التوصيل.',
        ),
      );
      return;
    }

    // التحقق من الإحداثيات عند التوصيل فقط.
    final latitude = isDelivery ? event.latitude : null;
    final longitude = isDelivery ? event.longitude : null;

    if (isDelivery && (latitude == null) != (longitude == null)) {
      emit(
        readyState.copyWith(
          errorMessage: 'بيانات موقع التوصيل غير مكتملة.',
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
            readyState.copyWith(
              errorMessage: 'توجد بيانات غير صحيحة لأحد منتجات السلة.',
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
        fulfillmentMethod: fulfillmentMethod,
        deliveryAddress: address,
        deliveryLatitude: latitude,
        deliveryLongitude: longitude,
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
          readyState.copyWith(
            errorMessage: failureMessage ?? 'تعذر إنشاء الطلب. حاول مرة أخرى.',
          ),
        );
        return;
      }

      emit(CheckoutState.success(order));

      // نحفظ عنوان وموقع العميل عند إنشاء طلب توصيل فقط.
      // فشل الحفظ لا يؤثر على الطلب المنشأ.
      if (isDelivery && latitude != null && longitude != null) {
        await _sellerRepository.updateMyDeliveryLocation(
          address: address!,
          latitude: latitude,
          longitude: longitude,
        );
      }
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        readyState.copyWith(
          errorMessage: 'حدث خطأ أثناء إرسال الطلب. حاول مرة أخرى.',
        ),
      );
    }
  }
}
