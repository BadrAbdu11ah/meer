import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';
import 'package:meer_flutter/repository/order_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(this._orderRepository) : super(const CheckoutState.initial()) {
    on<CheckoutSubmitted>(_onSubmitted);
  }

  final OrderRepository _orderRepository;

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
      );

      result.fold(
        (failure) {
          emit(
            CheckoutState.failure(failure.message),
          );
        },
        (order) {
          emit(
            CheckoutState.success(order),
          );
        },
      );
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
