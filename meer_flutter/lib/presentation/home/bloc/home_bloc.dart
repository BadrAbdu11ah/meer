import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/services/location_service.dart';
import 'package:meer_flutter/repository/local/city_local_repository.dart';
import 'package:meer_flutter/repository/product_repository.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;
  final CityLocalRepository _cityRepository;
  final LocationService _locationService;

  HomeBloc(
    this._productRepository,
    this._cityRepository,
    this._locationService,
  ) : super(const HomeState.initial()) {
    on<HomeStarted>(_onStarted);
    on<HomeProductsRequested>(_onProductsRequested);
    on<HomeCityChanged>(_onCityChanged);
  }

  /// المدينة المختارة حاليًا.
  MeerCity get city => _cityRepository.current;

  /// أول فتح للصفحة: المدينة المحفوظة، وإلا نحاول تحديدها من الموقع.
  Future<void> _onStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    final hasSavedCity = await _cityRepository.load();

    if (!hasSavedCity) {
      final detected = await _locationService.detectCity();

      if (detected != null) {
        await _cityRepository.save(detected);
      }
    }

    await _loadProducts(emit);
  }

  /// تغيير المدينة يدويًا.
  Future<void> _onCityChanged(
    HomeCityChanged event,
    Emitter<HomeState> emit,
  ) async {
    await _cityRepository.save(event.city);

    emit(const HomeState.loading());
    await _loadProducts(emit);
  }

  Future<void> _onProductsRequested(
    HomeProductsRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());
    await _loadProducts(emit);
  }

  /// تحميل منتجات المدينة المختارة من الخادم.
  Future<void> _loadProducts(Emitter<HomeState> emit) async {
    try {
      final result = await _productRepository.getAllAvailableProducts(
        _cityRepository.current,
      );

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
