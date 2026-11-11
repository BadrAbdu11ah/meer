import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:meer_flutter/repository/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this._repository) : super(const FavoritesState()) {
    on<FavoritesLoadRequested>(_onLoadRequested);
    on<FavoriteProductToggled>(_onProductToggled);
    on<FavoritesCleared>(_onCleared);
    on<FavoritesMessageCleared>(_onMessageCleared);
    on<FavoritesResetRequested>(_onResetRequested);
  }

  final FavoritesRepository _repository;

  int _sessionGeneration = 0;

  bool _isSessionCurrent(
    int sessionGeneration,
    Emitter<FavoritesState> emit,
  ) {
    return sessionGeneration == _sessionGeneration && !emit.isDone;
  }

  /// التعامل مع نتيجة العملية وإصدار الحالة المناسبة.
  void _handleResult(
    Either<Failure, List<Product>> result,
    Emitter<FavoritesState> emit, {
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
      (products) {
        emit(
          state.copyWith(
            products: List.unmodifiable(products),
            isLoading: false,
            message: successMessage,
          ),
        );
      },
    );
  }

  /// تحميل المفضلة من Serverpod.
  Future<void> _onLoadRequested(
    FavoritesLoadRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state.isLoading) return;

    final sessionGeneration = _sessionGeneration;

    emit(
      state.copyWith(
        isLoading: true,
        message: null,
      ),
    );

    final result = await _repository.getMyFavorites();

    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر تحميل المفضلة.',
    );
  }

  /// إضافة أو إزالة منتج من المفضلة.
  Future<void> _onProductToggled(
    FavoriteProductToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state.isLoading) return;

    final product = event.product;

    if (product.id == null) {
      emit(
        state.copyWith(
          message: 'تعذر تحديث المفضلة.',
        ),
      );
      return;
    }

    final isFavorite = state.containsProduct(product.id);

    final sessionGeneration = _sessionGeneration;

    emit(
      state.copyWith(
        isLoading: true,
        message: null,
      ),
    );

    final result = isFavorite
        ? await _repository.removeFavorite(product.id!)
        : await _repository.addFavorite(product);

    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر تحديث المفضلة.',
      successMessage: isFavorite
          ? 'تمت إزالة المنتج من المفضلة.'
          : 'تمت إضافة المنتج إلى المفضلة.',
    );
  }

  /// إفراغ مفضلة المستخدم الحالي.
  Future<void> _onCleared(
    FavoritesCleared event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state.isLoading) return;

    final sessionGeneration = _sessionGeneration;

    emit(
      state.copyWith(
        isLoading: true,
        message: null,
      ),
    );

    final result = await _repository.clearFavorites();

    if (!_isSessionCurrent(sessionGeneration, emit)) {
      return;
    }

    _handleResult(
      result,
      emit,
      errorMessage: 'تعذر إفراغ المفضلة.',
      successMessage: 'تم إفراغ المفضلة.',
    );
  }

  /// مسح رسالة التنبيه.
  void _onMessageCleared(
    FavoritesMessageCleared event,
    Emitter<FavoritesState> emit,
  ) {
    emit(
      state.copyWith(message: null),
    );
  }

  void _onResetRequested(
    FavoritesResetRequested event,
    Emitter<FavoritesState> emit,
  ) {
    _sessionGeneration++;

    emit(const FavoritesState());
  }
}
