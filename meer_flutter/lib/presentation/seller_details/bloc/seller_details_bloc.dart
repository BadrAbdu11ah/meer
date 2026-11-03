import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/product_repository.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

part 'seller_details_event.dart';
part 'seller_details_state.dart';
part 'seller_details_bloc.freezed.dart';

class SellerDetailsBloc extends Bloc<SellerDetailsEvent, SellerDetailsState> {
  SellerDetailsBloc(
    this._sellerRepository,
    this._productRepository,
  ) : super(const SellerDetailsState.initial()) {
    on<SellerDetailsLoadRequested>(_onLoadRequested);
  }

  final SellerRepository _sellerRepository;
  final ProductRepository _productRepository;

  Future<void> _onLoadRequested(
    SellerDetailsLoadRequested event,
    Emitter<SellerDetailsState> emit,
  ) async {
    emit(const SellerDetailsState.loading());

    try {
      final sellerResult = await _sellerRepository.getPublicSellerInfo(
        sellerId: event.sellerId,
      );

      SellerPublicInfo? seller;
      String? errorMessage;

      sellerResult.fold(
        (failure) {
          errorMessage = failure.message;
        },
        (value) {
          seller = value;
        },
      );

      if (seller == null) {
        emit(
          SellerDetailsState.error(
            errorMessage ?? 'تعذر تحميل معلومات الأسرة المنتجة.',
          ),
        );
        return;
      }

      final productsResult = await _productRepository.getProductsBySeller(
        event.sellerId,
      );

      List<Product>? products;

      productsResult.fold(
        (failure) {
          errorMessage = failure.message;
        },
        (value) {
          products = value;
        },
      );

      if (products == null) {
        emit(
          SellerDetailsState.error(
            errorMessage ?? 'تعذر تحميل منتجات الأسرة المنتجة.',
          ),
        );
        return;
      }

      emit(
        SellerDetailsState.loaded(
          seller: seller!,
          products: products!,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        const SellerDetailsState.error(
          'حدث خطأ أثناء تحميل صفحة الأسرة المنتجة.',
        ),
      );
    }
  }
}
