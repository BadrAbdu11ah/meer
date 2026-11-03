import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/product_repository.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;

  HomeBloc(this._productRepository) : super(const HomeState.initial()) {
    on<HomeProductsRequested>(_onProductsRequested);
  }

  /// تحميل المنتجات المتاحة من الخادم.
  Future<void> _onProductsRequested(
    HomeProductsRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    try {
      final result = await _productRepository.getAllAvailableProducts();

      result.fold(
        (failure) {
          emit(HomeState.error(failure.message));
        },
        (products) {
          emit(
            HomeState.productsLoaded(products: products),
          );
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        const HomeState.error(
          'حدث خطأ غير متوقع أثناء تحميل المنتجات.',
        ),
      );
    }
  }
}
