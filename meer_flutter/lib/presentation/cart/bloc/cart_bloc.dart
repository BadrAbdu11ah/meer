import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';
import 'package:meer_flutter/repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._cartRepository) : super(const CartState()) {
    on<CartLoadRequested>(_onLoadRequested);
    on<CartProductAdded>(_onProductAdded);
    on<CartQuantityIncreased>(_onQuantityIncreased);
    on<CartQuantityDecreased>(_onQuantityDecreased);
    on<CartProductRemoved>(_onProductRemoved);
    on<CartCleared>(_onCleared);
    on<CartMessageCleared>(_onMessageCleared);
    on<CartResetRequested>(_onResetRequested);
  }

  final CartRepository _cartRepository;

  int _sessionGeneration = 0;

  bool _isSessionCurrent(
    int sessionGeneration,
    Emitter<CartState> emit,
  ) {
    return sessionGeneration == _sessionGeneration && !emit.isDone;
  }

  /// معالجة نتيجة عملية السلة وإصدار الحالة المناسبة.
  void _handleResult(
    Either<Failure, List<CartItem>> result,
    Emitter<CartState> emit, {
    required String errorMessage,
    String? successMessage,
  }) {
    result.fold(
      (failure) {
        addError(failure, StackTrace.current);

        emit(
          state.copyWith(
            isLoading: false,
            message: errorMessage,
          ),
        );
      },
      (items) {
        emit(
          state.copyWith(
            items: List.unmodifiable(items),
            isLoading: false,
            message: successMessage,
          ),
        );
      },
    );
  }

  /// تحميل السلة الخاصة بالمستخدم الحالي.
  Future<void> _onLoadRequested(
    CartLoadRequested event,
    Emitter<CartState> emit,
  ) async {
    if (state.isLoading) return;

    final sessionGeneration = _sessionGeneration;

    emit(
      state.copyWith(
        isLoading: true,
        message: null,
      ),
    );

    final result = await _cartRepository.getMyCart();

    // تجاهل استجابة الجلسة السابقة.
    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر تحميل السلة.',
    );
  }

  /// إضافة منتج إلى السلة.
  Future<void> _onProductAdded(
    CartProductAdded event,
    Emitter<CartState> emit,
  ) async {
    if (state.isLoading) return;

    final product = event.product;

    if (product.id == null) {
      emit(state.copyWith(message: 'تعذر إضافة المنتج.'));
      return;
    }

    if (!product.isAvailable) {
      emit(
        state.copyWith(
          message: 'هذا المنتج غير متاح للبيع حاليًا.',
        ),
      );
      return;
    }

    // السلة الواحدة تخص أسرة منتجة واحدة.
    if (state.items.isNotEmpty &&
        state.items.first.product.sellerId != product.sellerId) {
      emit(
        state.copyWith(
          message:
              'السلة تحتوي على منتجات أسرة أخرى. '
              'أفرغ السلة أولًا لإضافة هذا المنتج.',
        ),
      );
      return;
    }
    final sessionGeneration = _sessionGeneration;

    emit(state.copyWith(isLoading: true, message: null));

    final result = await _cartRepository.addItem(product);
    // تجاهل استجابة الجلسة السابقة.
    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }
    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر إضافة المنتج إلى السلة.',
      successMessage: 'تمت إضافة المنتج إلى السلة.',
    );
  }

  /// زيادة كمية منتج.
  Future<void> _onQuantityIncreased(
    CartQuantityIncreased event,
    Emitter<CartState> emit,
  ) async {
    if (state.isLoading) return;

    final index = state.items.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index == -1) return;

    final item = state.items[index];

    if (!item.product.isAvailable) {
      emit(
        state.copyWith(
          message: 'هذا المنتج غير متاح للبيع حاليًا.',
        ),
      );
      return;
    }
    final sessionGeneration = _sessionGeneration;

    emit(state.copyWith(isLoading: true, message: null));

    final result = await _cartRepository.updateQuantity(
      productId: event.productId,
      quantity: item.quantity + 1,
    );
    // تجاهل استجابة الجلسة السابقة.
    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر زيادة كمية المنتج.',
    );
  }

  /// تقليل كمية منتج.
  Future<void> _onQuantityDecreased(
    CartQuantityDecreased event,
    Emitter<CartState> emit,
  ) async {
    if (state.isLoading) return;

    final index = state.items.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index == -1) return;

    final item = state.items[index];

    final sessionGeneration = _sessionGeneration;

    emit(state.copyWith(isLoading: true, message: null));

    // إذا كانت الكمية واحدًا، نحذف المنتج من السلة.
    final result = item.quantity <= 1
        ? await _cartRepository.removeItem(event.productId)
        : await _cartRepository.updateQuantity(
            productId: event.productId,
            quantity: item.quantity - 1,
          );

    // تجاهل استجابة الجلسة السابقة.
    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر تقليل كمية المنتج.',
    );
  }

  /// حذف منتج من السلة.
  Future<void> _onProductRemoved(
    CartProductRemoved event,
    Emitter<CartState> emit,
  ) async {
    if (state.isLoading) return;

    final sessionGeneration = _sessionGeneration;

    emit(state.copyWith(isLoading: true, message: null));

    final result = await _cartRepository.removeItem(event.productId);
    // تجاهل استجابة الجلسة السابقة.
    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر حذف المنتج من السلة.',
    );
  }

  /// إفراغ السلة بالكامل.
  Future<void> _onCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) async {
    if (state.isLoading) return;

    final sessionGeneration = _sessionGeneration;

    emit(state.copyWith(isLoading: true, message: null));

    final result = await _cartRepository.clearCart();

    // تجاهل استجابة الجلسة السابقة.
    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }
    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر إفراغ السلة.',
      successMessage: 'تم إفراغ السلة.',
    );
  }

  /// مسح رسالة التنبيه.
  void _onMessageCleared(
    CartMessageCleared event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(message: null));
  }

  void _onResetRequested(
    CartResetRequested event,
    Emitter<CartState> emit,
  ) {
    _sessionGeneration++;

    emit(const CartState());
  }
}
