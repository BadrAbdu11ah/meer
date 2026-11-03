import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/local/favorites_local_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(
    this._repository, {
    List<Product> initialFavorites = const [],
  }) : super(
         FavoritesState(
           products: List.unmodifiable(initialFavorites),
         ),
       ) {
    on<FavoriteProductToggled>(_onProductToggled);
    on<FavoritesCleared>(_onCleared);
    on<FavoritesMessageCleared>(_onMessageCleared);
  }

  final FavoritesLocalRepository _repository;

  Future<void> _onProductToggled(
    FavoriteProductToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    final product = event.product;

    if (product.id == null) {
      emit(
        state.copyWith(
          message: 'تعذر إضافة المنتج إلى المفضلة.',
        ),
      );
      return;
    }

    final products = List<Product>.from(state.products);

    final index = products.indexWhere(
      (item) => item.id == product.id,
    );

    final message = index != -1
        ? 'تمت إزالة المنتج من المفضلة.'
        : 'تمت إضافة المنتج إلى المفضلة.';

    if (index != -1) {
      products.removeAt(index);
    } else {
      products.add(product);
    }

    emit(
      state.copyWith(
        products: products,
        message: message,
      ),
    );

    await _saveFavorites(products, emit);
  }

  Future<void> _onCleared(
    FavoritesCleared event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesState());

    try {
      await _repository.clear();
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        state.copyWith(
          message: 'تعذر حذف المفضلة المحفوظة على الجهاز.',
        ),
      );
    }
  }

  void _onMessageCleared(
    FavoritesMessageCleared event,
    Emitter<FavoritesState> emit,
  ) {
    emit(
      state.copyWith(message: null),
    );
  }

  Future<void> _saveFavorites(
    List<Product> products,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _repository.saveFavorites(products);
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        state.copyWith(
          message: 'تم تحديث المفضلة، لكن تعذر حفظها على الجهاز.',
        ),
      );
    }
  }
}
