part of 'product_form_bloc.dart';

@freezed
sealed class ProductFormState with _$ProductFormState {
  const factory ProductFormState.initial() = ProductFormInitial;

  const factory ProductFormState.submitting() = ProductFormSubmitting;

  const factory ProductFormState.success(Product product) = ProductFormSuccess;

  const factory ProductFormState.failure(String message) = ProductFormFailure;
}
