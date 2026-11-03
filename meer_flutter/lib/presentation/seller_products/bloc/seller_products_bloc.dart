import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/product_repository.dart';

part 'seller_products_event.dart';
part 'seller_products_state.dart';
part 'seller_products_bloc.freezed.dart';

class SellerProductsBloc
    extends Bloc<SellerProductsEvent, SellerProductsState> {
  final ProductRepository _productRepository;

  SellerProductsBloc(this._productRepository)
    : super(const SellerProductsState.initial()) {
    on<SellerProductsStarted>(_onStarted);
    on<SellerProductsRefreshRequested>(_onRefreshRequested);
    on<SellerProductAvailabilityChanged>(_onAvailabilityChanged);
    on<SellerProductDeleteRequested>(_onDeleteRequested);
  }

  /// تحميل منتجات البائع الحالي.
  Future<void> _onStarted(
    SellerProductsStarted event,
    Emitter<SellerProductsState> emit,
  ) async {
    await _loadProducts(emit);
  }

  /// إعادة تحميل قائمة المنتجات.
  Future<void> _onRefreshRequested(
    SellerProductsRefreshRequested event,
    Emitter<SellerProductsState> emit,
  ) async {
    await _loadProducts(emit);
  }

  Future<void> _loadProducts(
    Emitter<SellerProductsState> emit,
  ) async {
    emit(const SellerProductsState.loading());

    try {
      final result = await _productRepository.getMyProducts();

      result.fold(
        (failure) {
          emit(SellerProductsState.error(failure.message));
        },
        (products) {
          emit(
            SellerProductsState.loaded(products: products),
          );
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        const SellerProductsState.error(
          'حدث خطأ أثناء تحميل منتجات متجرك.',
        ),
      );
    }
  }

  /// تغيير توفر منتج يملكه البائع الحالي.
  Future<void> _onAvailabilityChanged(
    SellerProductAvailabilityChanged event,
    Emitter<SellerProductsState> emit,
  ) async {
    final currentProducts = state.maybeWhen(
      loaded: (products, updatingProductIds, message) => products,
      orElse: () => null,
    );

    if (currentProducts == null) return;

    final currentUpdatingIds = state.maybeWhen(
      loaded: (products, updatingProductIds, message) => updatingProductIds,
      orElse: () => <int>{},
    );

    // منع إرسال أكثر من طلب لتحديث المنتج نفسه بالتزامن.
    if (currentUpdatingIds.contains(event.productId)) return;

    emit(
      SellerProductsState.loaded(
        products: currentProducts,
        updatingProductIds: {
          ...currentUpdatingIds,
          event.productId,
        },
      ),
    );

    try {
      final result = await _productRepository.toggleProductAvailability(
        productId: event.productId,
        isAvailable: event.isAvailable,
      );

      await result.fold<Future<void>>(
        (failure) async {
          final latestProducts = _currentProducts() ?? currentProducts;
          final latestUpdatingIds = _currentUpdatingIds()
            ..remove(event.productId);

          emit(
            SellerProductsState.loaded(
              products: latestProducts,
              updatingProductIds: latestUpdatingIds,
              message: failure.message,
            ),
          );
        },
        (_) async {
          // جلب الحالة الفعلية من الخادم بعد نجاح التحديث.
          final refreshed = await _productRepository.getMyProducts();

          refreshed.fold(
            (failure) {
              final latestProducts = _currentProducts() ?? currentProducts;
              final latestUpdatingIds = _currentUpdatingIds()
                ..remove(event.productId);

              emit(
                SellerProductsState.loaded(
                  products: latestProducts,
                  updatingProductIds: latestUpdatingIds,
                  message: failure.message,
                ),
              );
            },
            (products) {
              final latestUpdatingIds = _currentUpdatingIds()
                ..remove(event.productId);

              emit(
                SellerProductsState.loaded(
                  products: products,
                  updatingProductIds: latestUpdatingIds,
                ),
              );
            },
          );
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      final latestProducts = _currentProducts() ?? currentProducts;
      final latestUpdatingIds = _currentUpdatingIds()..remove(event.productId);

      emit(
        SellerProductsState.loaded(
          products: latestProducts,
          updatingProductIds: latestUpdatingIds,
          message: 'تعذر تحديث حالة المنتج.',
        ),
      );
    }
  }

  /// حذف منتج يملكه البائع الحالي.
  Future<void> _onDeleteRequested(
    SellerProductDeleteRequested event,
    Emitter<SellerProductsState> emit,
  ) async {
    final currentProducts = _currentProducts();

    // لا يمكن الحذف إذا لم تكن القائمة محمّلة.
    if (currentProducts == null) return;

    // التأكد من وجود المنتج في القائمة الحالية.
    final productExists = currentProducts.any(
      (product) => product.id == event.productId,
    );

    if (!productExists) return;

    final currentUpdatingIds = _currentUpdatingIds();

    // منع تنفيذ عمليتين متزامنتين على المنتج نفسه.
    if (currentUpdatingIds.contains(event.productId)) return;

    emit(
      SellerProductsState.loaded(
        products: currentProducts,
        updatingProductIds: {
          ...currentUpdatingIds,
          event.productId,
        },
      ),
    );

    try {
      final result = await _productRepository.deleteProduct(
        event.productId,
      );

      result.fold(
        (failure) {
          final latestProducts = _currentProducts() ?? currentProducts;
          final latestUpdatingIds = _currentUpdatingIds()
            ..remove(event.productId);

          emit(
            SellerProductsState.loaded(
              products: latestProducts,
              updatingProductIds: latestUpdatingIds,
              message: failure.message,
            ),
          );
        },
        (_) {
          final latestProducts = _currentProducts() ?? currentProducts;
          final latestUpdatingIds = _currentUpdatingIds()
            ..remove(event.productId);

          emit(
            SellerProductsState.loaded(
              products: latestProducts
                  .where((product) => product.id != event.productId)
                  .toList(),
              updatingProductIds: latestUpdatingIds,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      final latestProducts = _currentProducts() ?? currentProducts;
      final latestUpdatingIds = _currentUpdatingIds()..remove(event.productId);

      emit(
        SellerProductsState.loaded(
          products: latestProducts,
          updatingProductIds: latestUpdatingIds,
          message: 'حدث خطأ أثناء حذف المنتج.',
        ),
      );
    }
  }

  List<Product>? _currentProducts() {
    return state.maybeWhen(
      loaded: (products, updatingProductIds, message) => products,
      orElse: () => null,
    );
  }

  Set<int> _currentUpdatingIds() {
    return state.maybeWhen(
      loaded: (products, updatingProductIds, message) =>
          Set<int>.from(updatingProductIds),
      orElse: () => <int>{},
    );
  }
}
