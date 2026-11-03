import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';
import 'package:meer_flutter/repository/local/cart_local_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(
    this._cartLocalRepository, {
    List<CartItem> initialItems = const [],
  }) : super(
         CartState(items: List.unmodifiable(initialItems)),
       ) {
    on<CartProductAdded>(_onProductAdded);
    on<CartQuantityIncreased>(_onQuantityIncreased);
    on<CartQuantityDecreased>(_onQuantityDecreased);
    on<CartProductRemoved>(_onProductRemoved);
    on<CartCleared>(_onCleared);
    on<CartMessageCleared>(_onMessageCleared);
  }

  final CartLocalRepository _cartLocalRepository;

  /// إضافة منتج إلى السلة.
  Future<void> _onProductAdded(
    CartProductAdded event,
    Emitter<CartState> emit,
  ) async {
    final product = event.product;

    if (product.id == null) {
      emit(
        state.copyWith(message: 'تعذر إضافة المنتج.'),
      );
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

    final items = List<CartItem>.from(state.items);

    final existingIndex = items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      final existingItem = items[existingIndex];

      items[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      items.add(
        CartItem(product: product),
      );
    }

    emit(
      state.copyWith(
        items: items,
        message: 'تمت إضافة المنتج إلى السلة.',
      ),
    );

    await _persistItems(items, emit);
  }

  /// زيادة كمية منتج.
  Future<void> _onQuantityIncreased(
    CartQuantityIncreased event,
    Emitter<CartState> emit,
  ) async {
    final items = List<CartItem>.from(state.items);

    final index = items.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index == -1) return;

    items[index] = items[index].copyWith(
      quantity: items[index].quantity + 1,
    );

    emit(
      state.copyWith(
        items: items,
        message: null,
      ),
    );

    await _persistItems(items, emit);
  }

  /// تقليل كمية منتج.
  Future<void> _onQuantityDecreased(
    CartQuantityDecreased event,
    Emitter<CartState> emit,
  ) async {
    final items = List<CartItem>.from(state.items);

    final index = items.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index == -1) return;

    if (items[index].quantity <= 1) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity - 1,
      );
    }

    emit(
      state.copyWith(
        items: items,
        message: null,
      ),
    );

    await _persistItems(items, emit);
  }

  /// حذف منتج من السلة.
  Future<void> _onProductRemoved(
    CartProductRemoved event,
    Emitter<CartState> emit,
  ) async {
    final items = state.items
        .where(
          (item) => item.product.id != event.productId,
        )
        .toList();

    emit(
      state.copyWith(
        items: items,
        message: null,
      ),
    );

    await _persistItems(items, emit);
  }

  /// إفراغ السلة بالكامل.
  Future<void> _onCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) async {
    emit(const CartState());

    try {
      await _cartLocalRepository.clear();
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        state.copyWith(
          message: 'تم إفراغ السلة مؤقتًا، لكن تعذر حذف بياناتها المحفوظة.',
        ),
      );
    }
  }

  /// مسح رسالة التنبيه.
  void _onMessageCleared(
    CartMessageCleared event,
    Emitter<CartState> emit,
  ) {
    emit(
      state.copyWith(message: null),
    );
  }

  /// حفظ أحدث نسخة من السلة محليًا.
  Future<void> _persistItems(
    List<CartItem> items,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartLocalRepository.saveItems(items);
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        state.copyWith(
          message: 'تغيرت السلة، لكن تعذر حفظها على الجهاز.',
        ),
      );
    }
  }
}
