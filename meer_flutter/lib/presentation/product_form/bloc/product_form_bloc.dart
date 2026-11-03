import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/product_repository.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';
part 'product_form_bloc.freezed.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc(
    this._productRepository, {
    this.productToEdit,
  }) : super(const ProductFormState.initial()) {
    on<ProductFormSubmitted>(_onSubmitted);
  }

  final ProductRepository _productRepository;

  /// null تعني إضافة منتج، ووجود المنتج يعني تعديله.
  final Product? productToEdit;

  Future<void> _onSubmitted(
    ProductFormSubmitted event,
    Emitter<ProductFormState> emit,
  ) async {
    final name = event.name.trim();
    final price = double.tryParse(event.price.trim());
    final description = event.description?.trim();
    final imageUrl = event.imageUrl?.trim();

    if (name.isEmpty) {
      emit(
        const ProductFormState.failure(
          'يرجى إدخال اسم المنتج.',
        ),
      );
      return;
    }

    if (price == null || !price.isFinite || price <= 0) {
      emit(
        const ProductFormState.failure(
          'يرجى إدخال سعر صحيح أكبر من صفر.',
        ),
      );
      return;
    }

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final uri = Uri.tryParse(imageUrl);

      if (uri == null ||
          !uri.hasAuthority ||
          uri.host.isEmpty ||
          !(uri.scheme == 'http' || uri.scheme == 'https')) {
        emit(
          const ProductFormState.failure(
            'رابط الصورة غير صالح.',
          ),
        );
        return;
      }
    }

    emit(const ProductFormState.submitting());

    try {
      final existingProduct = productToEdit;

      final product = Product(
        id: existingProduct?.id,
        sellerId: existingProduct?.sellerId ?? 0,
        name: name,
        description: description == null || description.isEmpty
            ? null
            : description,
        price: price,
        imageUrl: imageUrl == null || imageUrl.isEmpty ? null : imageUrl,
        isAvailable: existingProduct?.isAvailable ?? true,
        createdAt: existingProduct?.createdAt ?? DateTime.now().toUtc(),
      );

      final result = existingProduct == null
          ? await _productRepository.addProduct(product)
          : await _productRepository.updateProduct(product);

      result.fold(
        (failure) {
          emit(ProductFormState.failure(failure.message));
        },
        (savedProduct) {
          emit(ProductFormState.success(savedProduct));
        },
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(
        ProductFormState.failure(
          productToEdit == null
              ? 'حدث خطأ أثناء إضافة المنتج. حاول مرة أخرى.'
              : 'حدث خطأ أثناء تعديل المنتج. حاول مرة أخرى.',
        ),
      );
    }
  }
}
